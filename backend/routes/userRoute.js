const express = require('express');
const router = express.Router();
const jwt = require('../utils/jwt');
const { register, login , getUser} = require('../controllers/userController');

router.post('/register', register);
router.post('/login', login);
router.get('/user',jwt.verifyToken, getUser);

module.exports = router;
