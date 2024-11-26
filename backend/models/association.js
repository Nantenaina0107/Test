// associations.js
const Paiement = require('./paiement');
const Declaration = require('./declaration');

// Définir les associations
Paiement.belongsTo(Declaration, { foreignKey: 'idD', targetKey: 'id' });
Declaration.hasMany(Paiement, { foreignKey: 'idD' });

// Exporter les modèles
module.exports = { Paiement, Declaration };
