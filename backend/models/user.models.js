import db from '../db.js';

async function createUser({ name, email, password }) {
  const result = await db.query(
    'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING *',
    [name, email, password]
  );
  return result.rows[0];
}

module.exports = { createUser };
