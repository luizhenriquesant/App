import OpenAI from 'openai';

export async function sendPrompt(prompt, messages, temperature, max_tokens = 1000) {
    console.log('Processando prompt:', prompt.substring(0, 50) + (prompt.length > 50 ? '...' : ''));

    if (!process.env.DEEP_SEEK_API_KEY) {
        throw new Error('API key não configurada');
    }

    const openai = new OpenAI({
        baseURL: 'https://api.deepseek.com/v1',
        apiKey: process.env.DEEP_SEEK_API_KEY,
        timeout: 60000 // 60 segundos
    });

    try {
        const startTime = Date.now();
        const completion = await openai.chat.completions.create({
            messages,
            model: 'deepseek-chat',
            temperature,
            max_tokens
        });

        const elapsedTime = Date.now() - startTime;
        console.log(`API response time: ${elapsedTime}ms`);

        if (!completion.choices?.[0]?.message?.content) {
            console.error('Resposta incompleta:', completion);
            throw new Error('Resposta da API incompleta');
        }

        return {
            success: true,
            recipe: completion.choices[0].message.content,
            usage: completion.usage
        };
    } catch (error) {
        console.error('Erro na API:', {
            message: error.message,
            code: error.code,
            stack: error.stack
        });

        return {
            success: false,
            error: 'Falha ao gerar receita',
            details: error.message
        };
    }
}