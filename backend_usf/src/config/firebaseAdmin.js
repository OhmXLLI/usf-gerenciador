// Carregar variáveis de ambiente
require('dotenv').config();
const admin = require('firebase-admin');

// Pegue o caminho do arquivo de credenciais a partir do arquivo .env
const serviceAccountPath = process.env.FIREBASE_CREDENTIALS_PATH;
const serviceAccount = require(serviceAccountPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports = admin;
