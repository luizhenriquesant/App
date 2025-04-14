import {createUser} from '../models/user.model.js';

async function registerUser(data) {
  // Aqui você pode validar, criptografar senha etc
  return await createUser(data);
}

export default registerUser;
