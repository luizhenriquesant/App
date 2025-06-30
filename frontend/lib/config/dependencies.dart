import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// import '../data/repositories/auth/auth_repository.dart';

import '../data/services/recipe/recipe_service.dart'; //ApiClient

import '../ui/core/services/image_service.dart';
import '../data/repositories/recipe/recipe_repository_impl.dart';
import '../data/repositories/recipe/recipe_repository.dart';

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
// List<SingleChildWidget> get providersRemote {
//   return [
//     // Provider(create: (context) => AuthApiClient()),
//     // Provider(create: (context) => ApiClient()),
//     // Provider(create: (context) => SharedPreferencesService()),
//     // ChangeNotifierProvider(
//     //   create:
//     //       (context) =>
//     //           AuthRepositoryRemote(
//     //                 authApiClient: context.read(),
//     //                 apiClient: context.read(),
//     //                 sharedPreferencesService: context.read(),
//     //               )
//     //               as AuthRepository,
//     // ),
//     Provider(
//       create: (context) =>
//           BookingRepositoryRemote(apiClient: context.read())
//               as BookingRepository,
//     ),
//     Provider(
//       create: (context) =>
//           UserRepositoryRemote(apiClient: context.read()) as UserRepository,
//     ),
//     ..._sharedProviders,
//   ];
// }

List<SingleChildWidget> get providersLocal {
  return [
    Provider<ApiClient>(lazy: true, create: (_) => ApiClient()),
    Provider<RecipeRepository>(
      lazy: true,
      create: (context) => RecipeRepositoryImpl(context.read<ApiClient>()),
    ),
    Provider<ImageService>(lazy: true, create: (_) => ImageService()),
  ];
}
