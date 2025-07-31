import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:logging/logging.dart';

import '../../core/services/image_service.dart';

import '../../../data/repositories/recipe/recipe_repository.dart';

import '../../../domain/models/recipe/recipe.dart';

import '../../../utils/command.dart';
import '../../../utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required ImageService imageService,
    required RecipeRepository recipeRepository,
  }) : _imageService = imageService,
       _recipeRepository = recipeRepository {
    pickFromCamera = Command0(_pickFromCamera);
    pickFromGallery = Command0(_pickFromGallery);
    uploadImage = Command0(() => _uploadImage());
    loadRecipes = Command0(_loadRecipes)..execute();
  }

  final ImageService _imageService;
  final RecipeRepository _recipeRepository;
  // final _log = Logger('HomeViewModel');

  XFile? _selectedImage;
  XFile? get selectedImage => _selectedImage;

  Recipe? _generatedRecipe;
  Recipe? get generatedRecipe => _generatedRecipe;

  Exception? _error;
  Exception? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  late Command0 loadRecipes;
  late Command0 pickFromCamera;
  late Command0 pickFromGallery;
  late Command0<void> uploadImage;

  // Future<void> _load() async {
  //   try {
  //     final result = Ok;
  //     switch (result) {
  //       case Ok():
  //         _log.fine('Loaded bookings');
  //       case Error():
  //         _log.warning('Failed to load bookings');
  //     }
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  Future<Result<void>> _loadRecipes() async {
    try {
      final result = await _recipeRepository.getAllRecipes();
      switch (result) {
        case Ok(value: final recipes):
          _recipes = recipes;
          print(
            'ViewModel: ${recipes.length} receitas carregadas com sucesso.',
          );
          notifyListeners(); // Notifica a UI que a lista foi atualizada
          return const Result.ok(null);

        case Error(error: final error):
          print('ViewModel: Erro ao carregar receitas: $error');
          // Você pode querer uma variável de erro separada para o load
          _error = error;
          notifyListeners();
          return Result.error(error);
      }
    } catch (e) {
      _error = Exception(e.toString());
      notifyListeners();
      return Result.error(_error!);
    }
  }

  Future<Result<void>> _pickFromCamera() async {
    try {
      _selectedImage = await _imageService.pickFromCamera();
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<void>> _pickFromGallery() async {
    try {
      _selectedImage = await _imageService.pickFromGallery();
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<void>> _uploadImage() async {
    if (_selectedImage == null) {
      final error = Exception('Nenhuma imagem selecionada');
      _error = error;
      notifyListeners();

      return Result.error(error);
    }

    _isLoading = true;
    _error = null;
    _generatedRecipe = null;
    notifyListeners();

    try {
      final result = await _recipeRepository.generateRecipe(
        File(_selectedImage!.path),
      );

      switch (result) {
        case Ok(value: final recipe):
          _generatedRecipe = recipe;
          print('ViewModel: _generatedRecipe foi definido com sucesso.');
          return const Result.ok(null);

        case Error(error: final error):
          _error = error;
          print('ViewModel: Erro ao gerar receita: $error');
          return Result.error(error);
      }
    } catch (e) {
      final error = Exception(e.toString());
      _error = error;
      return Result.error(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
