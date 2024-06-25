import 'package:get_it/get_it.dart';

import '../../features/home/presentation/manager/home_cubit.dart';

final getIt = GetIt.instance;

abstract class DependencyInjection {
  static Future<void> setUpLocator() async {
    //! Home
    getIt.registerFactory<HomeCubit>(() => HomeCubit());
  }
}
