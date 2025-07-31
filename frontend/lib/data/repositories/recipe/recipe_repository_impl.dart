import 'dart:io';
import '../../services/recipe/recipe_service.dart';
import '../../../utils/result.dart';
import '../../../domain/models/recipe/recipe.dart';
import './recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final ApiClient _service;

  RecipeRepositoryImpl(this._service);

  @override
  Future<Result<Recipe>> generateRecipe(File image) async {
    try {
      final resultFromService = await _service.generateRecipe(image);

      switch (resultFromService) {
        case Ok(value: final recipe):
          print('Repositório: Receita obtida com sucesso.');
          return Result.ok(recipe);

        case Error(error: final error):
          print('Repositório: Serviço retornou um erro: $error');
          return Result.error(error);
      }
    } catch (e) {
      print('Repositório: Capturou uma exceção inesperada: $e');
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Recipe>>> getAllRecipes() async {
    try {
      final resultFromService = await _service.getAllRecipes();

      switch (resultFromService) {
        case Ok(value: final recipe):
          print('Repositório: Receitas obtida com sucesso.');
          return Result.ok(recipe);

        case Error(error: final error):
          print('Repositório: Serviço retornou um erro: $error');
          return Result.error(error);
      }
    } catch (e) {
      print('Repositório: Capturou uma exceção inesperada: $e');
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try {
      // await _service.deleteRecipe(id);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<Recipe>> getRecipe(int id) async {
    try {
      // final recipeJson = await _service.getRecipe(id);
      return Result.ok(
        Recipe.fromJson({
          'id': id,
          'recipeText': 'Mock Recipe',
          'duration': '5 min',
        }),
      );
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
