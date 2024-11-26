const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./user');
const Declaration = require('./declaration');
const Paiement = require('./paiement')

const CarteFiscale = sequelize.define('CarteFiscale', {
  IdC: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  nif: {
    type: DataTypes.BIGINT,  // Entier de 10 chiffres
    allowNull: false,
    references: {
        model: User,
        key: 'nif'
    } 
  },
  idD: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: Declaration,  // Nom de votre table de déclaration
      key: 'id',
    },
  },
  idP: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: Paiement,  // Nom de votre table de paiements
      key: 'idP',
    },
  },
  qrCode: {
    type: DataTypes.TEXT , // Chemin ou données du QR code
    allowNull: true,
  },
}, {
  tableName: 'cartesFiscales',
});
  // Définir les associations
CarteFiscale.belongsTo(User, { foreignKey: 'nif' });
CarteFiscale.belongsTo(Declaration, { foreignKey: 'idD' });
CarteFiscale.belongsTo(Paiement, { foreignKey: 'idP' });
module.exports = CarteFiscale;
