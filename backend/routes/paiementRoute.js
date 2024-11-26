const express = require('express');
const router = express.Router();
const jwt = require('../utils/jwt');
const { getHistorique } = require('../controllers/paiementControlller')

router.get('/historique',jwt.verifyToken, getHistorique);

module.exports = router;