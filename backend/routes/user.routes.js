const userController = require('../controllers/user.controller');

async function userRoutes(fastify, options) {
  fastify.post('/users', userController.register);
}

module.exports = userRoutes;
