
const Declaration = require('../models/declaration');
const User = require('../models/user');
const Paiement = require('../models/paiement');
const CarteFiscale = require('../models/cartefiscale');

const QRCode = require('qrcode');
require('dotenv').config();


exports.carteFiscaleListe = async (req, res) => {
    try {
      const cartesFiscales = await CarteFiscale.findAll({
        where: { nif: req.user.nif }, // Utilisation du NIF de l'utilisateur depuis le JWT
        include: [
          {
            model: Paiement, // Inclure les informations de paiement
            attributes: ['ref', 'dateP'], // Inclure la référence et la date de paiement
          },
          {
            model: Declaration, // Inclure les informations de la déclaration
            attributes: ['status'], // Inclure le statut de la déclaration
          },
        ],
        attributes: ['nif'], // Sélectionnez uniquement le NIF
      });
  
      // Formatage des données pour renvoyer les informations nécessaires
      const result = cartesFiscales.map(carte => ({
        nif: carte.nif,
        refP: carte.Paiement.ref, // Référence de paiement
        status: carte.Declaration.status, // Statut de la déclaration
        dateP: carte.Paiement.dateP, // Date de paiement
      }));
  
      res.status(200).json(result);
    } catch (error) {
      res.status(500).json({ message: 'Erreur Serveur', error: error.message });
    }
};
exports.carteFiscaleDetail= async (req, res) => {
    try {
      const carteFiscale = await CarteFiscale.findByPk(req.params.idC, {
        include: [
          {
            model: Paiement, // Inclure les informations de paiement
            attributes: ['montantImpot', 'ref', 'dateP'], // Assurez-vous que ces champs existent dans votre modèle Paiement
          },
          {
            model: Declaration, // Inclure les informations de la déclaration
            attributes: ['status'], // Incluez le champ statut de la déclaration
          },
          {
            model: User, // Inclure les informations de l'utilisateur
            attributes: ['nom', 'prenom'], // Incluez les champs nom et prénom
          },
        ],
      });
  
      if (!carteFiscale) {
        return res.status(404).json({ message: 'Carte fiscale non trouvée' });
      }
  
      const details = {
        nif: carteFiscale.nif,
        nom: carteFiscale.User.nom,
        prenom: carteFiscale.User.prenom,
        status: carteFiscale.Declaration.status, // Assurez-vous que le statut est lié à la déclaration
        montantImpot: carteFiscale.Paiement.montantImpot,
        refPaiement: carteFiscale.Paiement.ref,
        datePaiement: carteFiscale.Paiement.dateP,
        qrCode: carteFiscale.qrCode,
      };
  
      res.status(200).json(details);
    } catch (error) {
      res.status(500).json({ message: 'Erreur Serveur', error: error.message });
    }
  };

exports.creerCarteFiscale = async (req, res) => {
    try {
        const nif = req.user.nif;
        const { idP } = req.params;

        // Récupérer les informations du paiement
        const paiement = await Paiement.findByPk(idP);
        if (!paiement) {
            return res.status(404).json({ message: 'Paiement non trouvé' });
        }

        const idD = paiement.idD;

        // Vérifier l'existence de l'utilisateur et de la déclaration
        const utilisateur = await User.findOne({ where: { nif } });
        const declaration = await Declaration.findByPk(idD);

        if (!utilisateur || !declaration) {
            return res.status(400).json({ message: 'Utilisateur ou Déclaration non trouvés' });
        }

        // Données supplémentaires pour le QR code
        const qrData = `
            NIF: ${nif}
            Nom: ${utilisateur.nom}
            Prénom: ${utilisateur.prenom}
            Statut Déclaration: ${declaration.status}
            Montant Déclaration: ${declaration.montantImpot}
            Date Paiement: ${paiement.datePaiement}
            Référence Paiement: ${paiement.reference}
        `;

        // Génération du QR code
        const qrCode = await QRCode.toDataURL(qrData);

        // Création de la carte fiscale dans la base de données
        const nouvelleCarte = await CarteFiscale.create({
            nif,
            idD,
            idP,
            qrCode,
        });

        res.status(201).json({ message: 'Carte fiscale créée avec succès', data: nouvelleCarte });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Erreur lors de la création de la carte fiscale', error: error.message });
    }
};

  