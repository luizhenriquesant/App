import {recipeGetter, getAllRecipes} from '../controllers/recipe.controller.js';

function recipeRoutes(fastify) {
    fastify.post('/recipe', recipeGetter);
    fastify.get('/recipes', getAllRecipes);
}

export default recipeRoutes;
