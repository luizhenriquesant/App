import {sendPrompt} from '../providers/openai.provider.js';
import {analyzeImage} from './google-cloud-vision-api/food-reg.service.js';

export async function postRecipe(imagePath) {
    const ingredientes = await analyzeImage(imagePath);
    console.log('Ingredientes encontrados:', ingredientes);
    const prompt = `Me dê uma receita com: ${ingredientes.join(', ')}`;
    const messages = [
        { role: 'system', content: 'Você é um chef de culinária profissional que fornece receitas detalhadas.' },
        { role: 'user', content: `Crie uma receita usando: ${prompt}, envie o tempo gasto nessa receita na ultima linha separado por ----- no formato Tempo total de preparo: x horas y minutos` }
    ];
    const resposta = await sendPrompt(prompt, messages, 0.7);
    console.log('Resposta recebida:', resposta);
    const parsedData = parseWithRegex(resposta.recipeText);
    return parsedData;
}

function parseWithRegex(fullText) {
  const regex = /^(.*?)\s*----+\s*\*\*Tempo.*:\*\*\s*(.*)$/s;

  const match = fullText.trim().match(regex);

  if (match && match.length === 3) {
    return {
      recipeText: match[1].trim(),
      duration: match[2].trim(),
    };
  }

  return {
    recipeText: fullText,
    duration: 'Não informado',
  };
}