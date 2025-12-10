import 'package:get_it/get_it.dart';
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
}