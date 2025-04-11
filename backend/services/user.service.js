const userModel = require('../models/user.model');

async function registerUser(data) {
  // Aqui você pode validar, criptografar senha etc
  return await userModel.createUser(data);
}

module.exports = { registerUser };
