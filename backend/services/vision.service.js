import { ClarifaiStub, grpc } from 'clarifai-nodejs-grpc';
import fs from 'fs';

export function analyzeImage(image) {
  const stub = ClarifaiStub.grpc();

  const metadata = new grpc.Metadata();
  metadata.set('authorization', `Key ${process.env.CLARIFAI_API_KEY}`);

  const imageBase64 = fs.readFileSync(image, { encoding: 'base64' });
  console.log('image,', imageBase64);

  // Retorna uma Promise para lidar com o fluxo assíncrono
  return new Promise((resolve, reject) => {
    stub.PostModelOutputs(
      {
        model_id: 'food-item-recognition', // Modelo específico para alimentos
        inputs: [
          {
            data: {
              image: {
                base64: imageBase64, // Imagem em Base64
              },
            },
          },
        ],
      },
      metadata,
      (err, response) => {
        if (err) {
          console.error('Erro ao chamar Clarifai:', err);
          return reject({ code: 500, error: 'Erro ao analisar imagem' });
        }

        if (response.status.code !== 10000) {
          console.error('Erro na resposta do Clarifai:', response.status.description);
          return reject({ code: response.status.code, error: response.status.description });
        }

        // Extrair os ingredientes detectados
        const ingredientes = response.outputs[0].data.concepts.map((concept) => ({
          nome: concept.name,
          probabilidade: concept.value,
        }));

        console.log('Ingredientes detectados:', ingredientes);
        resolve({ code: 200, output: ingredientes });
      }
    );
  });
}