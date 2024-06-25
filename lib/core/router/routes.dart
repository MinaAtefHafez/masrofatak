import 'package:flutter/material.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_details_screen.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/settings_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/splash_screen.dart';

abstract class CustomRouter {
  static Route onGenerateRoutes(RouteSettings settings) {
    final widget = switch (settings.name) {
      HomeDetailsScreen.name => const HomeDetailsScreen(),
      HomeScreen.name => const HomeScreen(),
      SettingsScreen.name => const SettingsScreen(),
      _ => const SplashScreen()
    };

    return MaterialPageRoute(builder: (_) => widget);
  }
}
