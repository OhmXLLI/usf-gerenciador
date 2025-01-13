const express = require('express');
const router = express.Router();
const authMiddleware = require('../middlewares/authMiddleware');
const admin = require('../config/firebaseAdmin');  // Firebase Admin
const Fila = require('../models/filaModel');  // Modelo de Fila no MongoDB

// Função para enviar notificação via Firebase
async function enviarNotificacao(token, mensagem) {
  const message = {
    token,
    notification: {
      title: 'Atualização de Fila',
      body: mensagem,
    },
  };

  try {
    await admin.messaging().send(message);
    console.log('Notificação enviada com sucesso!');
  } catch (error) {
    console.error('Erro ao enviar notificação:', error);
  }
}

// Rota para consultar posição na fila e enviar notificação quando há mudanças
router.get('/:pacienteId', authMiddleware, async (req, res) => {
  try {
    const { pacienteId } = req.params;

    // Busca o registro na fila
    const fila = await Fila.findOne({ pacienteId });
    if (!fila) return res.status(404).json({ message: 'Paciente não está na fila' });

    const tokenDispositivo = fila.tokenDispositivo;  // Token do Firebase do dispositivo do paciente

    // Simulação de mudança de posição para fins de conceito
    const novaPosicao = Math.max(1, fila.posicao - 1);
    fila.posicao = novaPosicao;
    await fila.save();

    // Enviar notificação sobre nova posição
    await enviarNotificacao(tokenDispositivo, `Sua nova posição na fila é ${novaPosicao}`);

    res.status(200).json({ posicao: novaPosicao });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao consultar fila ou enviar notificação' });
  }
});

module.exports = router;
