import {recipeGetter} from '../controllers/recipe.controller.js';

function recipeRoutes(fastify) {
    fastify.post('/recipe', recipeGetter);
}

export default recipeRoutes;
