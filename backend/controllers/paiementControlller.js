const Declaration = require('../models/declaration');
const User = require('../models/user');
const Paiement = require('../models/paiement');

require('dotenv').config();

exports.getHistorique = async (req, res) =>{
    try {
        const nif = req.user.nif;
        const paiements = await Paiement.findAll({
            include: [{
              model: Declaration,
              where: { nif: nif } // Assurez-vous que l'utilisateur a des déclarations
            }],
          });
      res.status(200).json({ message: 'Historique du paiements', data: paiements });
    } catch (error) {
      res.status(500).json({ message: "Erreur lors de la récuperations  de l'historique", error: error.message });
    }
  };