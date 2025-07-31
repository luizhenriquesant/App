// lib/presentation/screens/home/home_screen.dart

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/recipe/recipe.dart'; // Importe seu modelo
import '../../../routing/routes.dart';
import '../view_models/home_viewmodel.dart';
import 'home_app_bar.dart'; // Supondo que você tenha este widget

// Um widget de erro simples para seguir o padrão do exemplo
class ErrorIndicator extends StatelessWidget {
  final String title;
  final String label;
  final VoidCallback onPressed;
  const ErrorIndicator({
    super.key,
    required this.title,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: onPressed, child: Text(label)),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.uploadImage.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel != viewModel) {
      oldWidget.viewModel.uploadImage.removeListener(_onResult);
      viewModel.uploadImage.addListener(_onResult);
    }
  }

  @override
  void dispose() {
    viewModel.uploadImage.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    if (viewModel.uploadImage.completed) {
      final recipe = viewModel.generatedRecipe;
      if (recipe != null && mounted) {
        context.pushNamed(Routes.recipe, extra: recipe);
        viewModel.uploadImage.clearResult();
      }
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Escolher da galeria'),
              onTap: () async {
                Navigator.pop(context);
                await viewModel.pickFromGallery.execute();
                if (viewModel.selectedImage != null && mounted) {
                  viewModel.uploadImage.execute();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tirar uma foto'),
              onTap: () async {
                Navigator.pop(context);
                await viewModel.pickFromCamera.execute();
                if (viewModel.selectedImage != null && mounted) {
                  viewModel.uploadImage.execute();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.uploadImage.running ? null : _showImagePicker,
        backgroundColor: viewModel.uploadImage.running
            ? Colors.grey
            : Theme.of(context).primaryColor,
        child: const Icon(Icons.add_a_photo),
      ),
      body: ListenableBuilder(
        // Ouve o novo comando 'loadRecipes'
        listenable: viewModel.loadRecipes,
        builder: (context, child) {
          // Se o carregamento inicial está rodando, mostra o loading.
          if (viewModel.loadRecipes.running) {
            return const Center(child: CircularProgressIndicator());
          }

          // Se o carregamento inicial deu erro, mostra o indicador de erro.
          if (viewModel.loadRecipes.error) {
            return ErrorIndicator(
              title: 'Erro ao carregar suas receitas',
              label: 'Tentar Novamente',
              onPressed: viewModel.loadRecipes.execute,
            );
          }

          // Se não está rodando nem com erro, mostra o conteúdo principal.
          return child!;
        },
        // O child é o conteúdo que depende do estado de UPLOAD
        child: ListenableBuilder(
          listenable: viewModel.uploadImage,
          builder: (context, child) {
            // Se o UPLOAD está rodando, mostra um loading diferente (sobrepõe o conteúdo)
            if (viewModel.uploadImage.running) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Gerando sua nova receita...'),
                  ],
                ),
              );
            }
            // Senão, mostra o conteúdo principal
            return child!;
          },
          // O child final é a lista ou a tela de boas-vindas
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              // Se a lista de receitas NÃO ESTIVER VAZIA, mostre a lista.
              if (viewModel.recipes.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: viewModel.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = viewModel.recipes[index];
                    return _RecipeListItem(
                      recipe: recipe,
                      onTap: () =>
                          context.pushNamed(Routes.recipe, extra: recipe),
                    );
                  },
                );
              }

              // Se a lista estiver vazia, mostre a mensagem inicial.
              return const Center(
                child: Text(
                  'Nenhuma receita salva.\nSelecione uma imagem para começar!',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RecipeListItem extends StatelessWidget {
  const _RecipeListItem({required this.recipe, required this.onTap});

  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          // Pega a primeira linha do texto da receita como título
          recipe.recipeText.split('\n').first.replaceAll('**', ''),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('Duração: ${recipe.duration}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
