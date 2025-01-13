const bcrypt = require('bcryptjs');
const User = require('../models/userModel');

exports.register = async (req, res) => {
  const { nome, email, senha } = req.body;

  try {
    // Verificar se o usuário já existe
    const usuarioExistente = await User.findOne({ email });
    if (usuarioExistente) {
      return res.status(400).json({ message: 'E-mail já cadastrado!' });
    }

    // Criptografar a senha
    const hashedPassword = await bcrypt.hash(senha, 10);

    // Criar novo usuário
    const novoUsuario = new User({ nome, email, senha: hashedPassword });
    await novoUsuario.save();

    return res.status(201).json({ message: 'Usuário cadastrado com sucesso!' });
  } catch (error) {
    return res.status(500).json({ message: 'Erro no servidor.', error });
  }
};
