const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    await mongoose.connect('mongodb://localhost:xxxxxx');  // String de conexão simples
    console.log('Conexão com o MongoDB bem-sucedida!');
  } catch (error) {
    console.error('Erro ao conectar ao MongoDB:', error);
    process.exit(1);  // Finaliza o processo em caso de falha
  }
};

module.exports = connectDB;  // Exporta a função de conexão
