import 'package:get_it/get_it.dart';
import 'package:masrofatak/features/categories/data/repo/category_repo.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';

import '../../features/expenses_income/presentation/manager/expenses_income_cubit.dart';
import '../../features/home/presentation/manager/home_cubit.dart';

final getIt = GetIt.instance;

abstract class DependencyInjection {
  static Future<void> setUpLocator() async {
    //! Home
    getIt.registerFactory<HomeCubit>(() => HomeCubit());

    //! Categories
    getIt.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl());
    getIt.registerLazySingleton(() => CategoryCubit(getIt()));

    //! Expenses and income
    getIt.registerLazySingleton<ExpensesIncomeCubit>(
        () => ExpensesIncomeCubit());
    
}
}
