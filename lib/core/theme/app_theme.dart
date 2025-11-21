import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

ThemeData appLightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.backgroundColor,

  /// PRIMARY COLOR FIXED
  primaryColor: AppColors.primaryColor,

  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor, // FIXED PRIMARY COLOR
    onPrimary: Colors.white,         // Text/icon on primary
    secondary: AppColors.secondaryColor,
    onSecondary: AppColors.whiteColor,
    surface: AppColors.whiteColor,
    onSurface: AppColors.blackColor,
    error: AppColors.redColor,
    onError: AppColors.whiteColor,
  ),

  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: AppColors.whiteColor,
    iconTheme: IconThemeData(color: AppColors.blackColor),
  ),

  scrollbarTheme: ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(AppColors.secondaryColor),
    radius: Radius.circular(AppDimensions.scrollbarThumbRadius),
    thickness: WidgetStateProperty.all(AppDimensions.scrollbarThumbThickness),
  ),

  iconTheme: const IconThemeData(color: AppColors.blackColor),
  hintColor: Colors.grey,
  cardColor: AppColors.whiteColor,
  dividerTheme: const DividerThemeData(
    color: AppColors.greyColor,
    thickness: 0.5,
  ),

  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
);
