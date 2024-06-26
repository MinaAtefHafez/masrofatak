import 'package:flutter/material.dart';
import 'package:masrofatak/features/expenses_income/presentation/view/screens/add_expenses_income_screen.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_details_screen.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/settings_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/splash_screen.dart';

abstract class CustomRouter {
  static Route onGenerateRoutes(RouteSettings settings) {
    final widget = switch (settings.name) {
      AddExpensesIncomeScreen.name => const AddExpensesIncomeScreen(),
      HomeDetailsScreen.name => const HomeDetailsScreen(),
      HomeScreen.name => const HomeScreen(),
      SettingsScreen.name => const SettingsScreen(),
      _ => const SplashScreen()
    };

    return MaterialPageRoute(builder: (_) => widget);
  }
}
