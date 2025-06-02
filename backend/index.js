import Fastify from 'fastify';
import userRoutes from './routes/user.routes.js';
import recipeRoutes from './routes/recipe.routes.js';
import visionRoutes from './routes/vision.routes.js';
import 'dotenv/config';

const fastify = Fastify({ logger: true });

fastify.register(userRoutes);
fastify.register(recipeRoutes);
fastify.register(visionRoutes);

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