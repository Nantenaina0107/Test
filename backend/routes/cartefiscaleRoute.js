const express = require('express');
const router = express.Router();
const jwt = require('../utils/jwt');
const { carteFiscaleListe, carteFiscaleDetail, creerCarteFiscale } = require('../controllers/cartefiscaleController');

router.get('/cartesFiscales', jwt.verifyToken, carteFiscaleListe);
router.get('/carteFiscale/:idC', jwt.verifyToken, carteFiscaleDetail);
router.post('/carteFiscale/:idP', jwt.verifyToken, creerCarteFiscale);


module.exports = router;