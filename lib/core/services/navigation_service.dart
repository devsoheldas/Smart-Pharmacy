import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get navigator => navigatorKey.currentState;

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return navigator!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return navigator!.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    return navigator!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  void pop<T>([T? result]) {
    navigator!.pop(result);
  }
}
