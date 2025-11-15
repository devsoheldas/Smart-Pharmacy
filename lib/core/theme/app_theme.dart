import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData appLightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.backgroundColor,
  primaryColor: AppColors.blackColor,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: AppColors.textColorPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      fontFamily: 'Montserrat',
    ),
    titleMedium: TextStyle(
      color: AppColors.textColorPrimary,
      fontSize: 16.sp,
      fontFamily: 'Montserrat',
    ),
    titleSmall: TextStyle(
      color: AppColors.textColorPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      fontFamily: 'Montserrat',
    ),
    bodySmall: TextStyle(
      color: AppColors.textColorPrimary,
      fontSize: 12.sp,
      fontFamily: 'Montserrat',
    ),
    bodyMedium: TextStyle(
      color: AppColors.textColorPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      fontFamily: 'Montserrat',
    ),
    bodyLarge: TextStyle(
      color: AppColors.textColorPrimary,
      fontSize: 16.sp,
      fontFamily: 'Montserrat',
    ),
    displaySmall: TextStyle(
      color: AppColors.textColorPrimary,
      fontFamily: 'Montserrat',
      fontSize: 36.sp,
    ),
    displayMedium: TextStyle(
      color: AppColors.textColorPrimary,
      fontFamily: 'Montserrat',
      fontSize: 45.sp,
    ),
    displayLarge: TextStyle(
      color: AppColors.textColorPrimary,
      fontFamily: 'Montserrat',
      fontSize: 64.sp,
    ),
    labelSmall: TextStyle(
      color: AppColors.textColorPrimary,
      fontFamily: 'Montserrat',
      fontSize: 11.sp,
    ),
    labelMedium: TextStyle(
      color: AppColors.textColorPrimary,
      fontFamily: 'Montserrat',
      fontSize: 12.sp,
    ),
    labelLarge: TextStyle(
      color: AppColors.textColorPrimary,
      fontFamily: 'Montserrat',
      fontSize: 14.sp,
    ),
    headlineSmall: TextStyle(
      color: AppColors.textColorPrimary,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
      fontSize: 24.sp,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textColorPrimary,
      fontFamily: 'Montserrat',
      fontSize: 28.sp,
    ),
    headlineLarge: TextStyle(
      color: AppColors.textColorPrimary,
      fontFamily: 'Montserrat',
      fontSize: 32.sp,
    ),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: AppColors.whiteColor,
    iconTheme: IconThemeData(color: AppColors.blackColor), // Added icon theme// Added text theme for appBar title
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(AppColors.scrollbarThumbColor), // Set the thumb color
    radius: Radius.circular(AppDimensions.scrollbarThumbRadius), // Set the thumb radius (roundness)
    thickness: WidgetStateProperty.all(AppDimensions.scrollbarThumbThickness), // Set the thickness of the scrollbar thumb
  ),
  hintColor: Colors.grey,
  cardColor: AppColors.whiteColor,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor, // Primary color for the theme
    onPrimary: AppColors.blackColor, // Color for text/icons on the primary color
    secondary: AppColors.secondaryColor, // Add your secondary color
    onSecondary: AppColors.whiteColor, // Color for text/icons on background color
    surface: AppColors.whiteColor, // Surface color for elements like cards
    onSurface: AppColors.blackColor, // Color for text/icons on surface color
    error: AppColors.redColor, // Error color
    onError: AppColors.whiteColor, // Error text color
  ),
  iconTheme: const IconThemeData(
    color: AppColors.blackColor, // Set the default icon color
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.greyColor, // Divider color
    thickness: 0.5, // Divider thickness
  ),
  bottomAppBarTheme: BottomAppBarThemeData(
    color: AppColors.whiteColor, // Bottom app bar color
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primaryColor, // Button color
    textTheme: ButtonTextTheme.primary, // Button text color
  ),
);


ThemeData appDarkTheme = ThemeData.dark().copyWith(
  primaryColor: AppColors.whiteColor,
  scaffoldBackgroundColor: AppColors.whiteColor,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      fontFamily: 'Montserrat',
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 16.sp,
      fontFamily: 'Montserrat',
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      fontFamily: 'Montserrat',
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 12.sp,
      fontFamily: 'Montserrat',
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      fontFamily: 'Montserrat',
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 16.sp,
      fontFamily: 'Montserrat',
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 36.sp,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 45.sp,
    ),
    displayLarge: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 64.sp,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 11.sp,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 12.sp,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 14.sp,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
      fontSize: 24.sp,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 28.sp,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 32.sp,
    ),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    color: AppColors.blackColor,
    // color: hexToColor(darkBrandColor),
  ),
  hintColor: Colors.grey,
  cardColor: AppColors.whiteColor,
);
