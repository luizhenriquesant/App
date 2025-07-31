import vision from '@google-cloud/vision';

const client = new vision.ImageAnnotatorClient({
  keyFilename: 'food-rec-463315-f788277cbf34.json'
});

export async function analyzeImage(imagePath) {
  try {
    const [result] = await client.labelDetection(imagePath);
    const labels = result.labelAnnotations;

    const ingredientes = labels.map(label => label.description);
    return ingredientes;
  } catch (err) {
    console.error('Error analyzing image:', err);
    return null;
  }
}