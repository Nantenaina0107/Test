const jwt = require('jsonwebtoken');
const User = require('../models/user');
require('dotenv').config();

exports.verifyToken = async (req, res, next) => {
  const token = req.headers['authorization'];

  if (!token) {
    return res.status(403).send({ message: 'Token manquant.' });
  }

  // Suppression de "Bearer " si présent
  const actualToken = token.startsWith('Bearer ') ? token.slice(7, token.length) : token;

  jwt.verify(actualToken, process.env.JWT_SECRET, async (err, decoded) => {
    if (err) {
      return res.status(401).send({ message: 'Token invalide' });
    }

    // Recherche de l'utilisateur par NIF décodé
    const user = await User.findOne({ where: { nif: decoded.nif } });

    if (!user) {
      return res.status(404).send({ message: 'Utilisateur non trouvé' });
    }

    req.user = user;
    next();
  });
};
