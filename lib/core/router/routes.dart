import 'package:flutter/material.dart';
import 'package:masrofatak/features/categories/presentation/view/screens/add_new_category_screen.dart';
import 'package:masrofatak/features/expenses_income/presentation/view/screens/add_expenses_income_screen.dart';
import 'package:masrofatak/features/home/presentation/view/screens/day_details_screen.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_details_screen.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_screen.dart';
import 'package:masrofatak/features/reports/presentation/screens/reports_screen.dart';
import 'package:masrofatak/features/search/presentation/view/screens/search_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/settings_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/splash_screen.dart';

abstract class CustomRouter {
  static Route onGenerateRoutes(RouteSettings settings) {
    final widget = switch (settings.name) {
      SearchScreen.name => const SearchScreen(),
      AddNewCategoryScreen.name => const AddNewCategoryScreen(),
      ReportsScreen.name => const ReportsScreen(),
      DayDetailsScreen.name => const DayDetailsScreen(),
      AddExpensesIncomeScreen.name => const AddExpensesIncomeScreen(),
      HomeDetailsScreen.name => const HomeDetailsScreen(),
      HomeScreen.name => const HomeScreen(),
      SettingsScreen.name => const SettingsScreen(),
      _ => const SplashScreen()
    };

    return MaterialPageRoute(builder: (_) => widget);
  }
}
