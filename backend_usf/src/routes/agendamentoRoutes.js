const express = require('express');
const router = express.Router();

router.post('/agendamento', (req, res) => {
  const { userId, especialidade, periodo } = req.body;

  if (especialidade && periodo) {
    res.status(200).json({ mensagem: 'Consulta agendada com sucesso!' });
  } else {
    res.status(400).json({ mensagem: 'Erro ao agendar. Preencha todos os campos.' });
  }
});

module.exports = router;
