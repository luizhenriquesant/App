import userController from '../controllers/user.controller';

async function userRoutes(fastify) {
  fastify.post('/users', userController.register);
}

module.exports = userRoutes;
