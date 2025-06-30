import 'dart:io';

import '../../../domain/models/recipe/recipe.dart';
import '../../../utils/result.dart';

abstract class RecipeRepository {
  /// Returns a full [Recipe] given the id.
  Future<Result<Recipe>> getRecipe(int id);

  /// Creates a new [Recipe].
  Future<Result<Recipe>> generateRecipe(File image);

  /// Delete recipe
  Future<Result<void>> delete(int id);
}
