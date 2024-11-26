const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { sendEmail } = require('../utils/email');
require('dotenv').config();

//Générer un NIF
async function generateUniqueNIF() {
  let nif;
  let isUnique = false;

  while (!isUnique) {
    // Génération du NIF (10 chiffres)
    nif = Math.floor(1000000000 + Math.random() * 9000000000);

    // Vérifier si le NIF existe déjà
    const existingUser = await User.findOne({ where: { nif: nif } });

    // Si aucun utilisateur avec ce NIF n'est trouvé, alors il est unique
    if (!existingUser) {
      isUnique = true;
    }
  }

  return nif;
}

//Inscription 
exports.register = async (req,res)=>
{
  const {email, nom, prenom, cin ,sexe , situation, password, tel, datenaiss, lieunaiss, activites, sieges }= req.body;
  if (!email || !password || !cin || !nom || !prenom) {
    return res.status(400).json({ message: 'Veuillez fournir toutes les informations requises.' });
  }
  try {
    const existingEmail = await User.findOne({where: { email }});
    if (existingEmail) {
      return res.status(400).json({messsage : 'Email already registered'});
    }
    const existingUser = await User.findOne({ where: { cin } });
    if (existingUser) {
      return res.status(400).json({ message: 'CIN already registered' });
    }

    const nif = await generateUniqueNIF();
    const hashedPassword = await bcrypt.hash(password, 10);
    // Si aucune activité n'est spécifiée, on en crée une par défaut
    if (!activites || activites.length === 0) {
      activites.push({
          secteur: 'Commerce', // Secteur par défaut
          description: 'N/A', // Description par défaut
          isInvestisseur: false, // Valeur par défaut
          secteurInv: null // Valeur par défaut
      });
  } else {
      // Assurez-vous que le champ secteurInv est géré correctement
      activites.forEach(activite => {
          if (!activite.isInvestisseur) {
              activite.secteurInv = null; // Assurez-vous que secteurInv est null si ce n'est pas un investisseur
          }
      });
  }

    const user = await User.create({
      nif, email, nom, prenom, cin ,sexe , situation, password: hashedPassword, tel, datenaiss, lieunaiss, activites, sieges,
    });
    sendEmail(email, nif, res);
    /*const token = jwt.sign({ nif },
      process.env.JWT_Secret, { expiresIn : '1h'}
    );*/
    res.status(201).json({ message : 'User Registered successfully', nif})  
  } catch (error) {
    console.error(error);
    res.status(500).json({message : 'Server error'});
  }
}

exports.login = async (req,res) =>{
  const { nif, password }= req.body;
  try {
    const user = await User.findOne({ where: { nif }});
    if (!user) {
      return res.status(400).json({messsage : 'Invalid nif or password'}); 
    }
    const isMatch = await bcrypt.compare(password,user.password);
    if (!isMatch) {
      return res.status(400).json({messsage : 'Invalid nif or password'}); 
    }
    //Générer un token JWT
    const token = jwt.sign({ nif: user.nif },
      process.env.JWT_Secret, { expiresIn : '1h'}
    );
    res.status(200).json({ messsage : 'Login successfull', token});

  } catch (error) {
    console.error(error);
    res.status(500).json({messsage : 'Server error'});
  }
};
// controllers/userController.js

exports.getUser = async (req, res) => {
  try {
    const user = req.user; // L'utilisateur est déjà vérifié et accessible via req.user
    const userData = {
      nif: user.nif,
      activites: user.activites[0], // Inclure les activités de l'utilisateur
    };

    res.status(200).json(userData);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération des données de l\'utilisateur' });
  }
};

