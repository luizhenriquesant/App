import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/recipe/recipe_repository.dart';
import '../ui/core/services/image_service.dart';
import '../ui/home/view_models/home_viewmodel.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/recipe/widgets/recipe_screen.dart';
import '../../../domain/models/recipe/recipe.dart';

import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewModel(
          imageService: context.read<ImageService>(),
          recipeRepository: context.read<RecipeRepository>(),
        );
        return HomeScreen(viewModel: viewModel);
      },
    ),
    GoRoute(
      name: Routes.recipe,
      path: '/recipe',
      builder: (context, state) {
        final recipe = state.extra as Recipe;
        return RecipeScreen(recipe: recipe);
      },
    ),
  ],
);
