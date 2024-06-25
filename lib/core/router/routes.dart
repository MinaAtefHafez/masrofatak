import 'package:flutter/material.dart';
import 'package:masrofatak/features/auth/presentation/view/screens/auth_screen.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/settings_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/splash_screen.dart';

abstract class CustomRouter {
  static Route onGenerateRoutes(RouteSettings settings) {
    final widget = switch (settings.name) {
      HomeScreen.name => const HomeScreen(),
      AuthScreen.name => const AuthScreen(),
      DetailsScreen.name => const DetailsScreen(),
      _ => const SplashScreen()
    };

    return MaterialPageRoute(builder: (_) => widget);
  }
}
