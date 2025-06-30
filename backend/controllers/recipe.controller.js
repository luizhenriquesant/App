import { promisify } from 'node:util';
import { pipeline } from 'node:stream';
import fs from 'node:fs';
import path from 'node:path';
import { randomUUID } from 'node:crypto';
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

        return res.code(201).send(recipe);
    } catch (err) {
        return res.code(500).send({ error: 'Erro interno', details: err.message });
    }
};