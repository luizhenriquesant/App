import {analyzeImage} from '../services/vision.service.js';

export const visionGetter = async (req, res) => {
    try {
        const { image } = req.body;
        if (!image) return res.code(400).send({ error: 'Campo obrigatorio ausente' });
        const {output, code} = await analyzeImage(image);

        return res.code(code).send(output);
    } catch (err) {
        return res.code(500).send({ error: 'Erro interno', details: err.message });
    }
};