const express = require('express');
const router = express.Router();
const jwt = require('../utils/jwt');
const { creerDeclaration, getDeclarations, annulerDeclaration, validerDeclaration, payerDeclaration, confirmer } = require('../controllers/declarationController');

router.post('/declaration', jwt.verifyToken, creerDeclaration);
router.get('/listesDeclaration',jwt.verifyToken, getDeclarations);
router.delete('/declaration/:id',jwt.verifyToken, annulerDeclaration);
router.put('/declaration/:id',jwt.verifyToken, validerDeclaration);
router.post('/declaration/:id/creer',jwt.verifyToken, payerDeclaration);
router.put('/declaration/:id/confirmer',jwt.verifyToken, confirmer);

module.exports = router;