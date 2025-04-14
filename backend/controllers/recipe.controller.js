import {getRecipes} from '../services/recipe.service.js';

export const recipeGetter = async (req, res) => {
    try {
        const { ingredients } = req.body;
        if (!ingredients) return res.code(400).send({ error: 'Campo obrigatorio ausente' });
        const recipe = await getRecipes(ingredients);

        return res.code(201).send(recipe);
    } catch (err) {
        return res.code(500).send({ error: 'Erro interno', details: err.message });
    }
};