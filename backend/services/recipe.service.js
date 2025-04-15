import {sendPrompt} from '../providers/openai.provider.js';

export async function getRecipes(ingredientes) {
    const prompt = `Me dê uma receita com: ${ingredientes.join(', ')}`;
    const messages = [
        { role: 'system', content: 'Você é um chef de culinária profissional que fornece receitas detalhadas.' },
        { role: 'user', content: `Crie uma receita usando: ${prompt}` }
    ];
    const resposta = await sendPrompt(prompt, messages, 0.7);

    return resposta;
}
