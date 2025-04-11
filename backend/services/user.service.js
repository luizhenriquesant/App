import userModel from '../models/user.model.js';

async function registerUser(data) {
  // Aqui você pode validar, criptografar senha etc
  return await userModel.createUser(data);
}

module.exports = { registerUser };
