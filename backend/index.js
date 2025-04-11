import Fastify from 'fastify';
import userRoutes from './routes/user.routes.js';
import formBody from '@fastify/formbody';

const fastify = Fastify({ logger: true });

fastify.register(formBody); // para req.body
fastify.register(userRoutes);

const start = async () => {
  try {
    await fastify.listen({ port: 3000 });
    console.log('Server listening on http://localhost:3000');
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();