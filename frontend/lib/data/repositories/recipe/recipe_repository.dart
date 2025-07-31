import 'dart:io';

import '../../../domain/models/recipe/recipe.dart';
import '../../../utils/result.dart';

abstract class RecipeRepository {
  /// Returns a full [Recipe] given the id.
  Future<Result<Recipe>> getRecipe(int id);

  /// Creates a new [Recipe].
  Future<Result<Recipe>> generateRecipe(File image);

  /// Return all [Recipe]
  Future<Result<List<Recipe>>> getAllRecipes();

  /// Delete recipe given the id
  Future<Result<void>> delete(int id);
}
