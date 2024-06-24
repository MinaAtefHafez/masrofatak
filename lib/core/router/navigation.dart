import 'package:flutter/widgets.dart';

 final navigatorKey = GlobalKey<NavigatorState>();

abstract class CustomNavigator {

 
  static void pushNamed(String routeName, {Object? arguments}) {
    navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static void pushAndReplacementNamed(String routeName, {Object? arguments}) {
    navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pop([int pop = 1]) {
    for (int index = 0; index < pop; index++) {
      navigatorKey.currentState!.pop();
    }
  }
}
