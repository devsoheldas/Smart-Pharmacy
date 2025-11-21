import 'package:e_pharma/feature/auth/screens/login_screen.dart';
import 'package:e_pharma/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../feature/auth/screens/reset_password_screen.dart';
import '../feature/auth/screens/singup_screen.dart';
import '../feature/product/screens/home_screen.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String splashScreen = '/splash_screen';
  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/singup_screen';
  // static const String otpVerificationScreen = '/otp_verification_screen';
  // static const String forgotPasswordScreen = '/forgot_password_screen';
  // static const String forgotPasswordSubmitScreen = '/forgot_password_submit_screen';
  static const String resetPasswordScreen = '/reset_password_screen';
  static const String homeScreen = '/home_screen';
  // static const String myProfileScreen = '/my_profile_screen';
  // static const String editProfileScreen = '/edit_profile_screen';
  // static const String productDetailsScreen = '/product_details_screen';


  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      loginScreen: (context) => const LoginScreen(),
      signupScreen: (context) => const SignupScreen(),
      // otpVerificationScreen: (context) {
      //   final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      //   if (args == null) throw ArgumentError('args is required for /OtpVerificationScreen');
      //   return OtpVerificationScreen(phone: args['phone'],userId: args['userId']);
      // },
      // forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
      // forgotPasswordSubmitScreen: (context) => const ForgotPasswordSubmitScreen(),
      resetPasswordScreen: (context) {
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        if (args == null) throw ArgumentError('args is required for /ResetPasswordScreen');
        return ResetPasswordScreen(email: args['email']);
      },
      homeScreen: (context) => HomeScreen(),
      // myProfileScreen: (context) => MyProfileScreen(),
      // editProfileScreen: (context) => EditProfileScreen(),
      // productDetailsScreen: (context) {
      //   final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      //   if (args == null) throw ArgumentError('args is required for /ProductDetailsScreen');
      //   return ProductDetailsScreen(productSlug: args['productSlug'], productId: args['productId']);
      // },
    };
  }

}
