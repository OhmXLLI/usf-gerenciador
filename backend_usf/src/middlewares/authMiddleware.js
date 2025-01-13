const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
  const token = req.headers['authorization'];
  if (!token) return res.status(401).json({ message: 'Token não fornecido.' });

  jwt.verify(token, process.env.SECRET_KEY, (err, decoded) => {
    if (err) return res.status(403).json({ message: 'Token inválido ou expirado.' });

    const now = Math.floor(Date.now() / 1000); // Timestamp atual em segundos
    if (decoded.exp < now) {
      return res.status(403).json({ message: 'Sessão expirada, faça login novamente.' });
    }

    req.userId = decoded.id; // Guarda o ID do usuário autenticado para uso nas rotas
    next(); // Chama o próximo middleware ou a rota
  });
};
