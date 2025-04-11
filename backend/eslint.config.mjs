import { defineConfig } from "eslint/config";
import js from "@eslint/js";
import globals from "globals";
import pluginReact from "eslint-plugin-react";

export default defineConfig([
  // Configuração base para JavaScript
  {
    ignores: ["node_modules", "dist", "build"],
    files: ["**/*.{js,mjs,cjs,jsx}"],
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
      },
    },
    rules: {
      // Proíbe variáveis não utilizadas
      'no-unused-vars': 'error',

      // Força o uso de async/await quando necessário
      'require-await': 'error',

      // Proíbe o uso de métodos inexistentes (como res.code)
      'no-undef': 'error',

      // Impede múltiplas linhas vazias
      'no-multiple-empty-lines': ['error', { max: 1, maxEOF: 0 }],

      // Remove espaços em branco desnecessários
      'no-trailing-spaces': 'error',
    },
  },

  // Configuração recomendada para JavaScript
  js.configs.recommended,

  // Configuração recomendada para React
  {
    files: ["**/*.{jsx}"],
    plugins: {
      react: pluginReact,
    },
    settings: {
      react: {
        version: "detect", // Detecta automaticamente a versão do React
      },
    },
    rules: {
      "react/react-in-jsx-scope": "off", // Desabilita a regra se estiver usando React 17+
      "react/jsx-uses-vars": "error",
    },
  },
]);