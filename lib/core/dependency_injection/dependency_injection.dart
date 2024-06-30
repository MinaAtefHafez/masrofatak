import 'package:get_it/get_it.dart';
import 'package:masrofatak/features/categories/data/repo/category_repo.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/expenses_income/data/repo/expenses_income_repo.dart';
import 'package:masrofatak/features/reports/presentation/manager/reports_cubit.dart';

import '../../features/expenses_income/presentation/manager/expenses_income_cubit.dart';
import '../../features/home/presentation/manager/home_cubit.dart';

final getIt = GetIt.instance;

abstract class DependencyInjection {
  static Future<void> setUpLocator() async {
    //! Home
    getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());

    //! Categories
    getIt.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl());
    getIt.registerLazySingleton(() => CategoryCubit(getIt()));

    //! Expenses and income
    getIt.registerLazySingleton<ExpensesIncomeRepo>(
        () => ExpensesIncomeRepoImpl());
    getIt.registerLazySingleton<ExpensesIncomeCubit>(
        () => ExpensesIncomeCubit(getIt()));

    //! reports
    //
    getIt.registerLazySingleton(() => ReportsCubit());
  }
}
