import {register} from '../controllers/user.controller.js';

function userRoutes(fastify) {
  fastify.post('/users', register);
}

export default userRoutes;