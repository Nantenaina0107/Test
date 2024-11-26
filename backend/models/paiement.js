const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Declaration = require('./declaration');

const Paiement = sequelize.define('Paiement', {
  idP: {
    type: DataTypes.INTEGER,  // Entier de 10 chiffres
    primaryKey: true,
    autoIncrement:true,
  },
  idD: {
    type: DataTypes.INTEGER,  // Entier de 10 chiffres
    allowNull: false,
    references: {
        model: Declaration,
        key: 'id'
    } 
  },
  montantImpot: {
    type: DataTypes.DECIMAL(18,2),
    allowNull: false,
  },
  ref: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  dateP: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: DataTypes.NOW,
  },
  status: {
    type: DataTypes.STRING,
    allowNull: true,
  },
}, {
  tableName:'paiements',
});

module.exports = Paiement;