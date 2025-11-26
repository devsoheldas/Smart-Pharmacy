import 'package:e_pharma/feature/address/address_list_screen.dart';
import 'package:e_pharma/feature/auth/screens/login_screen.dart';
import 'package:e_pharma/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../feature/auth/screens/reset_password_screen.dart';
import '../feature/auth/screens/singup_screen.dart';
import '../feature/home/screens/home_screen.dart';
import '../feature/order/order_history_screen.dart';
import '../feature/profile/profile_screen.dart';
import '../feature/wishlist/wishlist_screen.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String splashScreen = '/splash_screen';
  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/singup_screen';
  static const String resetPasswordScreen = '/reset_password_screen';
  static const String homeScreen = '/home_screen';
  static const String profileScreen = '/profile_screen';
  static const String orderHistoryScreen = '/order_history_screen';
  static const String wishlistScreen = '/wishlist_screen';
  static const String addressListScreen = '/address_list_screen';
  // static const String productDetailsScreen = '/product_details_screen';


  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      loginScreen: (context) => const LoginScreen(),
      signupScreen: (context) => const SignupScreen(),
      resetPasswordScreen: (context) {
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        if (args == null) throw ArgumentError('args is required for /ResetPasswordScreen');
        return ResetPasswordScreen(email: args['email']);
      },
      homeScreen: (context) => HomeScreen(),
      profileScreen: (context) => ProfileScreen(),
      orderHistoryScreen: (context) => OrderHistoryScreen(),
      wishlistScreen: (context) => WishlistScreen(),
      addressListScreen: (context) => AddressListScreen(),
      // productDetailsScreen: (context) {
      //   final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      //   if (args == null) throw ArgumentError('args is required for /ProductDetailsScreen');
      //   return ProductDetailsScreen(productSlug: args['productSlug'], productId: args['productId']);
      // },
    };
  }

}
