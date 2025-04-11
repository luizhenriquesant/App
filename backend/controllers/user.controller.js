const userService = require('../services/user.service');

exports.register = async (req, reply) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return reply.code(400).send({ error: 'Campos obrigatórios ausentes' });
    }

    const user = await userService.registerUser({ name, email, password });
    return reply.code(201).send(user);
  } catch (err) {
    if (err.code === '23505') { // email duplicado
      return reply.code(409).send({ error: 'Email já cadastrado' });
    }
    return reply.code(500).send({ error: 'Erro interno', details: err.message });
  }
};
