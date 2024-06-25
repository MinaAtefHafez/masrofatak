import 'package:get_it/get_it.dart';
import 'package:masrofatak/features/auth/presentation/manager/auth_cubit.dart';

import '../../features/auth/data/repository/auth_repository.dart';

final getIt = GetIt.instance;

abstract class DependencyInjection {
  static Future<void> setUpLocator() async {
    //! Auth
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepoImpl());
    getIt.registerLazySingleton(() => AuthCubit(getIt()));
  }
}
