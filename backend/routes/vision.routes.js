import {visionGetter} from '../controllers/vision.controller.js';

function visionRoutes(fastify) {
    fastify.post('/analize-image', visionGetter);
}

export default visionRoutes;
