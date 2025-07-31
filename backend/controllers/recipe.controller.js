import { promisify } from 'node:util';
import { pipeline } from 'node:stream';
import fs from 'node:fs';
import path from 'node:path';
import { randomUUID } from 'node:crypto';
import { prisma } from '../prisma/prisma/prisma.js';
import { postRecipe } from '../services/recipe.service.js';

const pump = promisify(pipeline);

export const recipeGetter = async (req, res) => {
    try {
        const data = await req.file();
        if (!data) {
            return res.code(400).send({ error: 'Nenhum arquivo de imagem foi enviado.' });
        }

        const extension = path.extname(data.filename);
        const uniqueFilename = `${randomUUID()}${extension}`;
        const filePath = path.join('uploads', uniqueFilename);

        await pump(data.file, fs.createWriteStream(filePath));

        const recipe = await postRecipe(filePath);
        const newRecipe = await prisma.recipe.create({
        data: {
            recipeText: recipe.recipeText,
            duration: recipe.duration,
        },
        });
        console.log(`Receita salva com sucesso! ID: ${newRecipe.id}`);
        return res.code(201).send(recipe);
    } catch (err) {
        return res.code(500).send({ error: 'Erro interno', details: err.message });
    }
};

export const getAllRecipes = async (req, res) => {
  try {
    console.log('Buscando todas as receitas...');
    const recipes = await prisma.recipe.findMany({
      orderBy: {
        createdAt: 'desc',
      },
    });

    return res.code(200).send(recipes);

  } catch (err) {
    console.error('Erro ao buscar receitas:', err);
    return res.code(500).send({ error: 'Erro interno ao buscar receitas' });
  }
};