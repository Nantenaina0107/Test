const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const User = sequelize.define('User', {
  nif: {
    type: DataTypes.BIGINT,  // Entier de 10 chiffres
    primaryKey: true,
    autoIncrement:false,
    unique: true,
  },
  nom: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  prenom: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  sexe: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  situation: {
    type: DataTypes.STRING, // Par exemple: 'Célibataire', 'Marié', etc.
    allowNull: false,
  },
  tel: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  datenaiss: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  lieunaiss: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  cin: {
    type: DataTypes.BIGINT, // Numéro CIN
    allowNull:false,
    unique: true,
  }, 
  activites:{
    type: DataTypes.JSONB,
    allowNull:false,
  },
  sieges:{
    type: DataTypes.JSONB,
    allowNull:false,
  },
}, {
  tableName:'users',
});

module.exports = User;