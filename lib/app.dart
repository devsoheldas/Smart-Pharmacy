
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'feature/address/address_list_screen.dart';

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
          home: AddressListScreen(),
        );
      },
    );
  }
}
