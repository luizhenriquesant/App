# Recipe AI: A Cozinha Consciente de Contexto 🤖🍳

**Autor:** [Seu Nome Completo]
**Projeto para a disciplina:** Computação Pervasiva e Ubíqua

Recipe AI é um protótipo de aplicativo full-stack que explora conceitos de computação pervasiva para resolver o "bloqueio criativo" na cozinha. Utilizando um modelo de IA de visão computacional, o aplicativo gera receitas a partir de uma foto dos ingredientes que o usuário tem em mãos, tornando a tecnologia uma assistente invisível e contextual.

## ✨ Conceitos e Funcionalidades

Este projeto foi desenvolvido com foco nos seguintes princípios de Computação Pervasiva:

* **Consciência de Contexto:** O sistema captura o contexto do usuário (ingredientes disponíveis) através da câmera, em vez de exigir que ele o descreva textualmente.
* **Interação Implícita e Natural:** A ação de "mostrar" ingredientes é mais natural e fluida do que a busca tradicional por receitas, reduzindo a carga cognitiva.
* **Inteligência no Ambiente:** O aplicativo aumenta a percepção dos objetos físicos (ingredientes), associando a eles uma camada de informação digital (receitas).
* **Persistência de Dados:** As receitas geradas são salvas em um banco de dados local para consulta futura, criando uma "memória" para o usuário.

### Funcionalidades Implementadas
* Gerar receitas a partir de uma imagem (via câmera ou galeria).
* Parseamento automático do texto da IA para separar o corpo da receita e a duração.
* Salvar automaticamente cada nova receita em um banco de dados.
* Listar todas as receitas salvas na tela inicial.
* Navegar para uma tela de detalhes para visualizar a receita completa.

## 🛠️ Pilha de Tecnologias (Stack)

O projeto é dividido em duas partes principais:

#### **Frontend (Mobile)**
* **Framework:** [Flutter](https://flutter.dev/)
* **Gerenciamento de Estado:** ChangeNotifier com Injeção de Dependência e Padrão `Command`.
* **Navegação:** [GoRouter](https://pub.dev/packages/go_router)
* **Comunicação:** Pacote `http`

#### **Backend (Servidor)**
* **Framework:** [Node.js](https://nodejs.org/) com [Fastify](https://www.fastify.io/)
* **Banco de Dados:** [SQLite](https://www.sqlite.org/index.html) (para desenvolvimento)
* **ORM:** [Prisma](https://www.prisma.io/)
* **Inteligência Artificial:** A integração é feita com uma API externa de um Modelo de Linguagem de Visão (LVM).

## 🚀 Arquitetura

O fluxo de dados da aplicação segue os seguintes passos:

1.  **Flutter App:** O usuário seleciona uma imagem. A `View` (HomeScreen) aciona um `Command` no `ViewModel`.
2.  **ViewModel:** Executa a lógica de upload, chamando o `Repository`.
3.  **Repository:** Envia a imagem via requisição `POST /recipe` para o backend.
4.  **Backend (Fastify):** Recebe a imagem, a envia para a API da IA e recebe de volta um texto bruto.
5.  **Parsing:** O backend parseia o texto bruto usando Regex para extrair `recipeText` e `duration`.
6.  **Banco de Dados (Prisma):** O backend salva a receita estruturada no banco de dados SQLite.
7.  **Resposta:** O backend retorna o objeto da receita salva (com ID) em formato JSON.
8.  **Flutter App:** O `ViewModel` recebe o sucesso, emite um evento de navegação, e a `View` navega para a tela de detalhes da receita.

## ⚙️ Como Executar o Projeto Localmente

Siga os passos abaixo para configurar e rodar o ambiente de desenvolvimento.

### Pré-requisitos
* [Node.js](https://nodejs.org/en) (versão 18 ou superior)
* [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão 3.10 ou superior)
* Um emulador Android configurado ou um dispositivo físico.

---

### 1. Configuração do Backend

```bash
# 1. Navegue até a pasta do backend
cd backend

# 2. Instale as dependências do Node.js
npm install

# 3. Configure o banco de dados. O Prisma irá ler o schema.prisma
# e criar o arquivo de banco de dados SQLite.
npx prisma migrate dev --name init-recipe

# 4. Inicie o servidor do backend.
# Por padrão, ele rodará em http://localhost:8080
npm run dev