import 'package:get_it/get_it.dart';
import 'package:sweetella/feature/address/data/data_source/address_remote_data_source.dart';
import 'package:sweetella/feature/address/data/data_source/address_remote_data_source_imp.dart';
import 'package:sweetella/feature/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:sweetella/feature/cart/data/data_sources/cart_remote_data_source_imp.dart';
import 'package:sweetella/feature/address/data/repositories/address_repo.dart';
import 'package:sweetella/feature/address/data/repositories/address_repo_impl.dart';
import 'package:sweetella/feature/cart/data/repositories/cart_firebase_repo_imp.dart';
import 'package:sweetella/feature/cart/data/repositories/cart_repo.dart';
import 'package:sweetella/feature/address/presentation/cubits/address_cubit.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/favorites/data/data_sources/favories_remote_data_source.dart';
import 'package:sweetella/feature/favorites/data/data_sources/favorties_remote_data_source_imp.dart';
import 'package:sweetella/feature/favorites/data/repositories/favorit_firebase_repo_imp.dart';
import 'package:sweetella/feature/favorites/data/repositories/favorites_firebase_repo.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/home/data/repositories/product_repo_imp.dart';
import 'package:sweetella/feature/home/data/services/product_firebase_service.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/profile/data/data_source/profile_remote_data_source.dart';
import 'package:sweetella/feature/profile/data/data_source/profile_remote_data_source_imp.dart';
import 'package:sweetella/feature/profile/data/repos/profile_repo.dart';
import 'package:sweetella/feature/profile/data/repos/profile_repo_imp.dart';
import 'package:sweetella/feature/profile/presentation/cubits/profile_cubit.dart';
import 'package:sweetella/feature/search/data/data_source/search_remote_data_source.dart';
import 'package:sweetella/feature/search/data/data_source/search_remote_data_source_imp.dart';
import 'package:sweetella/feature/search/data/repos/search_repo.dart';
import 'package:sweetella/feature/search/data/repos/search_repo_imp.dart';
import 'package:sweetella/feature/search/presentation/bloc/search_bloc.dart';
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
  sl.registerFactory(() => FavoritesCubit(favoritesRepo: sl()));

  // cart data source
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImp(),
  );

  // cart Repositories
  sl.registerLazySingleton<CartRepo>(
    () => CartFirebaseRepoImp(cartRemoteDataSource: sl()),
  );
  //cart cubit
  sl.registerFactory(() => CartCubit(cartRepo: sl()));

  // address data source
  sl.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSourceImp(),
  );

  // address repository
  sl.registerLazySingleton<AddressRepo>(() => AddressRepoImp(sl()));

  // address cubit
  sl.registerFactory(() => AddressCubit(addressRepo: sl()));

  // search data source
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImp(),
  );

  // search Repositories
  sl.registerLazySingleton<SearchRepository>(() => SearchRepoImp(sl()));
  //search bloc
  sl.registerFactory(() => SearchBloc(sl()));

  // profile data source
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImp(),
  );

  //profile repo
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImp(sl()));

  //profile Cubit
  sl.registerFactory(() => ProfileCubit(sl()));
}
