import 'package:e_pharma/feature/splash/splash_screen.dart';
import 'package:e_pharma/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_strings.dart';
import 'core/services/navigation_service.dart';
import 'core/theme/app_theme.dart';
import 'feature/order/order_confirmed_screen.dart';
import 'feature/order/order_confirmed_successful_screen.dart';

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
          navigatorKey: NavigationService.navigatorKey,
          routes: AppRoutes.getRoutes(),
          debugShowCheckedModeBanner: false,
           home: SplashScreen(),
          // home: OrderConfirmedSuccessfulScreen(),
        );
      },
    );
  }
}
