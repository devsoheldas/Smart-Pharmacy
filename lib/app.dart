import 'package:e_pharma/feature/checkout/checkout_screen.dart';
import 'package:e_pharma/feature/checkout/payment_succesful_screen.dart';
import 'package:e_pharma/feature/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 932),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          theme: appLightTheme,
          darkTheme: appLightTheme,
          themeMode: ThemeMode.system,
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          // home: HomeScreen(),
          home: PaymentSuccesfulScreen(),
        );
      },
    );
  }
}
