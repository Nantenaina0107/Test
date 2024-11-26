const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./user');

const Declaration = sequelize.define('Declaration', {
  id: {
    type: DataTypes.INTEGER,  // Entier de 10 chiffres
    primaryKey: true,
    autoIncrement:true,
  },
  nif: {
    type: DataTypes.BIGINT,  // Entier de 10 chiffres
    allowNull: false,
    references: {
        model: User,
        key: 'nif'
    } 
  },
  anneFiscal: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  chiffreAffaires: {
    type: DataTypes.DECIMAL(18,2),
    allowNull: false,
  },
  montantInvestissement: {
    type: DataTypes.DECIMAL(18,2),
    allowNull: false,
    defaultValue: 0,
  },
  montantImpot: {
    type: DataTypes.DECIMAL(18,2),
    allowNull: false,
  },
  status: {
    type: DataTypes.ENUM("Soumise",'Non payé','payé','En retard'),
    allowNull: false,
    defaultValue: 'Soumise',
  },
  dateDeclaration: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: DataTypes.NOW,
  },
  dateLimite: {
    type: DataTypes.DATE,
    allowNull: false,
  },
}, {
  tableName:'declarations',
});

module.exports = Declaration;