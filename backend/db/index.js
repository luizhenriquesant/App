import pg from 'pg';
const { Pool } = pg;

const db = new Pool({
  user: 'seu_usuario',
  host: 'localhost',
  database: 'seu_banco',
  password: 'sua_senha',
  port: 5432,
});

export default db;