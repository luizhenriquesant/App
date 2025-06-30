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
        listenable: viewModel.uploadImage,
        builder: (context, child) {
          if (viewModel.uploadImage.running) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.uploadImage.error) {
            return ErrorIndicator(
              title: 'Erro ao gerar a receita',
              label: 'Tentar Novamente',
              onPressed: viewModel.uploadImage.execute,
            );
          }
          return child!;
        },
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final image = viewModel.selectedImage;
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: image != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(image.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const Text('Selecione uma imagem para começar'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
