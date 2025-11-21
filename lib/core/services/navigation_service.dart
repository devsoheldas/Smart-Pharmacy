import 'package:flutter/material.dart';

class NavigationService {
  // Static navigator key
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Getter for navigator
  static NavigatorState? get navigator => navigatorKey.currentState;

  // Push a new screen by route name
  static Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return navigator!.pushNamed(routeName, arguments: arguments);
  }

  // Replace current screen with a new one
  static Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return navigator!.pushReplacementNamed(routeName, arguments: arguments);
  }

  // Push a new screen and remove all previous screens
  static Future<dynamic> pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    return navigator!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  // Pop the current screen
  static void pop<T>([T? result]) {
    navigator!.pop(result);
  }
}
