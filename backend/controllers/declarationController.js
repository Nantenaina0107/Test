const { default: Stripe } = require('stripe');
const Declaration = require('../models/declaration');
const User = require('../models/user');
const paiement = require('../models/paiement');
require('dotenv').config();
const stripe = Stripe(process.env.Stripe_secret_key);

/*exports.creerDeclaration = async (req, res) => {
    try {
      const { chiffreAffaires , montantInvestissement, anneFiscal } = req.body;
  
      const user = req.user;
      const nif = user.nif;
      const activites = user.activites;
  
      // Vérification de la présence des champs secteur et description
      if (!activites || activites.length === 0) {
        return res.status(400).json({ message: 'Les activités sont obligatoires.' });
      }
  
      const activite = activites[0]; // On prend la première activité (ou ajustez selon le cas)
      const secteur = activite.secteur;
      const description = activite.description;
      const isInvestisseur = activite.isInvestisseur;
  
      // Vérifier que le secteur et la description sont bien remplis
      if (!secteur || secteur.trim() === '') {
        return res.status(400).json({ message: 'Le secteur est obligatoire.' });
      }
  
      if (!description || description.trim() === '') {
        return res.status(400).json({ message: 'La description est obligatoire.' });
      }
  
      // Calcul du montant d'impôt
      let montantImpot = chiffreAffaires * 0.2;
      const investissement = isInvestisseur ? montantInvestissement : 0;
      if (investissement > 0) {
        montantImpot -= investissement * 0.1;
      }
  
      const dateLimite = new Date();
      dateLimite.setDate(dateLimite.getDate() + 30);
  
      const newDeclaration = await Declaration.create({
        nif,
        chiffreAffaires,
        montantInvestissement: investissement,
        anneFiscal,
        montantImpot,
        status: 'Soumise',
        dateLimite,
      });
  
      res.status(201).json({ message: 'Déclaration créée avec succès', data: newDeclaration });
    } catch (error) {
      res.status(500).json({ message: 'Erreur lors de la création de la déclaration', error: error.message });
    }
  };*/
  exports.creerDeclaration = async (req, res) => {
    try {
        const { chiffreAffaires, montantInvestissement, anneFiscal } = req.body;

        const user = req.user;
        const nif = user.nif;
        const activites = user.activites;

        // Vérification des activités
        if (!activites || activites.length === 0) {
            return res.status(400).json({ message: 'Les activités sont obligatoires.' });
        }

        const activite = activites[0]; // Utilisation de la première activité
        const secteur = activite.secteur;
        const isInvestisseur = activite.isInvestisseur;

        // Si l'utilisateur n'est pas investisseur, le montantInvestissement est forcé à 0.0
        const investissement = isInvestisseur ? montantInvestissement : 0.0;

        // Calcul du montant d'impôt
        let montantImpot = 0;
        let minimumPerception = 0;

        // Détermination du minimum de perception en fonction du secteur
        if (['Agriculture', 'Artisanat', 'Industrie', 'Minière', 'Hôtellerie', 'Tourisme'].includes(secteur)) {
            minimumPerception = 500000 + (0.01 * chiffreAffaires);
        } else if (secteur === 'Vente de carburants') {
            minimumPerception = (0.002 * chiffreAffaires); // 2 ‰
        } else {
            minimumPerception = 1000000 + (0.01 * chiffreAffaires);
        }

        // Calcul de l'impôt en fonction des règles spécifiques
        if (isInvestisseur && investissement >= 0.0) {
            const impotInitial = chiffreAffaires * 0.2; // Taux d'impôt de 20 %
            const reductionInvestissement = Math.min(investissement * 0.2, 0.5 * impotInitial);
            montantImpot = impotInitial - reductionInvestissement;
        } else if (!isInvestisseur && montantInvestissement > 0) {
          // Cas d'un non-investisseur qui entre un montant d'investissement : taux standard sans réduction
          montantImpot = chiffreAffaires * 0.2;
        } else {
            //const beneficeImposable = chiffreAffaires * 0.5; // Supposons un bénéfice de 50 % du chiffre d'affaires
            montantImpot = chiffreAffaires * 0.2; // Taux d'impôt de 20 %
        }

        // Appliquer le minimum de perception
        montantImpot = Math.max(montantImpot, minimumPerception);

        // Création de la déclaration
        const dateLimite = new Date();
        dateLimite.setDate(dateLimite.getDate() + 30);

        const newDeclaration = await Declaration.create({
            nif,
            chiffreAffaires,
            montantInvestissement: investissement,
            anneFiscal,
            montantImpot,
            status: 'Soumise',
            dateLimite,
        });

        res.status(201).json({ message: 'Déclaration créée avec succès', data: newDeclaration });
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la création de la déclaration', error: error.message });
    }
};

  exports.getDeclarations = async (req, res) =>{
    try {
      const declaration = await Declaration.findAll({
        where:{nif : req.user.nif}
      });
      res.status(200).json({ message: 'Listes du Déclaration ', data: declaration });
    } catch (error) {
      res.status(500).json({ message: 'Erreur lors de la récuperations  de la déclaration', error: error.message });
    }
  };
  exports.annulerDeclaration = async (req, res) =>{
    try {
      const declaration = await Declaration.findByPk(req.params.id);
      if (declaration && declaration.nif === req.user.nif) {
        if (declaration.status === "Soumise") {
          await declaration.destroy();
          res.status(200).json({ message: "Declaration annulée avec succès" });
        }else{
          res.status(400).json({ message: "seule le declaration avec statut soumise peuvent être annuler" });
        }
      }else{
        res.status(404).json({ message: "Declaration non trouvé ou non autorisé" });
      }
    } catch (error) {
      res.status(500).json({ message: 'Erreur Serveur', error: error.message });
    }
  };
  exports.validerDeclaration = async (req, res) => {
    try {
      const declaration = await Declaration.findByPk(req.params.id);
  
      // Vérifiez si la déclaration existe et si le NIF correspond
      if (!declaration) {
        return res.status(404).json({ message: "Déclaration non trouvée" });
      }
  
      if (declaration.nif !== req.user.nif) {
        return res.status(403).json({ message: "Accès non autorisé" });
      }
  
      // Vérifiez si le statut est "Soumise"
      if (declaration.status === "Soumise") {
        declaration.status = "Non payé";  // Mettez à jour le statut
        await declaration.save();
        return res.status(200).json({ message: "Déclaration validée avec succès" });
      } else {
        return res.status(400).json({
          message: "Seules les déclarations avec le statut 'Soumise' peuvent être validées",
        });
      }
    } catch (error) {
      console.error(error);  // Afficher l'erreur dans la console pour le débogage
      return res.status(500).json({ message: 'Erreur Serveur', error: error.message });
    }
  };
  
  exports.payerDeclaration = async (req, res) =>{
    try {
      const declaration = await Declaration.findByPk(req.params.id);
      if (declaration && declaration.nif === req.user.nif) {
        if (declaration.status !== "payé") {
          const amount = declaration.montantImpot;
          
          const paymentIntent = await stripe.paymentIntents.create({
            amount : amount/100*100,
            currency : "MGA",
            automatic_payment_methods: {
              enabled: true,
              allow_redirects: 'never' // Ne jamais autoriser les redirections
            },
          });
          
          
          res.status(200).json({ clientSecret : paymentIntent.client_secret, paymentIntentId: paymentIntent.id,});
        }else{
          res.status(400).json({ message: "seule le declaration avec statut !payé peuvent être payer" });
        }
      }else{
        res.status(404).json({ message: "Declaration non trouvé ou non autorisé" });
      }
    } catch (error) {
      res.status(500).json({ message: 'Erreur Serveur', error: error.message });
    }
  };
  exports.confirmer = async (req, res) =>{
    const declarationId = req.params.id;
    
    try {
      const { paymentIntentId } = req.body;
      const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);
      if (paymentIntent.status === 'succeeded') {
        const newPaiement = await paiement.create({
          ref: paymentIntent.id,
          idD: declarationId,
          montantImpot: paymentIntent.amount,
          dateP: new Date(),
          status: paymentIntent.status,
        });
        const declaration = await Declaration.findByPk(declarationId);
        

        if (declaration) {
          declaration.status = "payé";
          await declaration.save();
        }
        console.log('paymentIntentId reçu:', paymentIntentId);
        console.log('Déclaration trouvée:', declaration);

        return res.status(200).json({ message : "Paiement réussi et declaration mise à jour", newPaiement});
        
      }else{
        return res.status(400).json({ message: "Paiement non valide" });
    }
    } catch (error) {
      res.status(500).json({ message: 'Erreur Serveur', error: error.message });
    } 
  };
  