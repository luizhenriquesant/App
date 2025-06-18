// index.js

// 1. Import and configure the Vision client
import vision from '@google-cloud/vision';

// Create a new client, passing in your service account key file
const client = new vision.ImageAnnotatorClient({
  keyFilename: 'food-rec-463315-2920a07de1bf.json'
});

// 2. Define an async function to analyze child-friendliness
async function analyzeImage(imagePath) {
  try {
    const [result] = await client.labelDetection(imagePath);
    const labels = result.labelAnnotations;

    console.log('Possíveis ingredientes encontrados:');
    labels.forEach(label => {
      console.log(`- ${label.description} (score: ${label.score.toFixed(2)})`);
    });

    // Se quiser, pode retornar só os nomes dos ingredientes como array
    const ingredientes = labels.map(label => label.description);
    console.log('ingredientes', ingredientes);
    return ingredientes;
  } catch (err) {
    console.error('Error analyzing image:', err);
    return null;
  }
}

// 3. Test the function with your chosen image
const testImagePath = 'ingredientes.jpg';
analyzeImage(testImagePath);
