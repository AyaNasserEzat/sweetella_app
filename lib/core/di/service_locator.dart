import 'package:get_it/get_it.dart';
import 'package:sweetella/feature/favorites/data/data_sources/favories_remote_data_source.dart';
import 'package:sweetella/feature/favorites/data/data_sources/favorties_remote_data_source_imp.dart';
import 'package:sweetella/feature/favorites/data/repositories/favorit_firebase_repo_imp.dart';
import 'package:sweetella/feature/favorites/data/repositories/favorites_firebase_repo.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/home/data/repositories/product_repo_imp.dart';
import 'package:sweetella/feature/home/data/services/product_firebase_service.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import '../services/firebase_service.dart';
import '../../feature/auth/data/repositories/auth_repo_impl.dart';
import '../../feature/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Services
  sl.registerLazySingleton(() => FirebaseServices());

  // Repositories
  sl.registerLazySingleton(() => AuthRepoImpl(sl<FirebaseServices>()));

  // Cubits
  sl.registerFactory(() => AuthCubit(sl<AuthRepoImpl>()));

  // product Services
  sl.registerLazySingleton(() => ProductFirebaseService());

  // Repositories
  sl.registerLazySingleton(() => ProductRepoImp(sl<ProductFirebaseService>()));

  // Cubits
  sl.registerFactory(() => ProductCubit(sl<ProductRepoImp>()));

  // favorites data source
  sl.registerLazySingleton<FavoritesRemoteDataSource>(
    () => FavortiesRemoteDataSourceImp(),
  );

  // favorites Repositories
  sl.registerLazySingleton<FavoritesRepo>(
    () => FavoritFirebaseRepoImp(favoritesRemoteDataSource: sl()),
  );
  //favorites cubit
  sl.registerFactory(() => FavoritesCubit(favoritesRepo: sl(),));
}
