const express = require('express');
const authController = require('../controllers/authController');

const router = express.Router();

// Rota de cadastro
router.post('/register', authController.register);

module.exports = router;
