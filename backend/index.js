const Fastify = require('fastify');
const userRoutes = require('./routes/user.routes');

const fastify = Fastify({ logger: true });

fastify.register(require('@fastify/formbody')); // para req.body
fastify.register(userRoutes);

fastify.listen({ port: 3000 }, err => {
  if (err) throw err;
});
