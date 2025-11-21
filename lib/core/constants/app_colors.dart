import 'package:flutter/material.dart';

class AppColors {
  /// MAIN BRAND COLORS
  static const Color primaryColor = Color(0xff7048D4);
  static const Color secondaryColor = Color(0xff9775FA);

  /// LIGHT & BACKGROUND TONES (purple)
  static const Color lightPrimaryColor = Color(0xFFE9DDFE);
  static const Color backgroundColor = Color(0xFFFFFFFF);

  /// TEXT COLORS
  static const Color textColorPrimary = Color(0xFF1C1C1C);
  static const Color textColor = Color(0xFF1C1C1C);
  static const Color textGreyColor = Color(0xFF7D7D7D);
  static const Color textColorSecondary = Color(0xFF3B3B3B);

  /// PURPLE-SUITED UI COLORS
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color darkWhite = Color(0xFFF4F4F4);
  static const Color greenishWhite = Color(0xFFF7F5FF);
  static const Color blackColor = Color(0xFF000000);
  static const Color blackDark = Color(0xFF292929);
  static const Color blackMedium = Color(0xFF2F2F2F);
  static const Color blackLight = Color(0xFF1D1E20);

  /// GREYS NEUTRALIZED FOR PURPLE THEME
  static const Color greyColor = Color(0xFF8C8C8C);
  static const Color greyLight = Color(0xFFBDBDBD);
  static const Color greyDark = Color(0xFF4F4F4F);
  static const Color greyMedium = Color(0xFF6D6D6D);

  static const Color transparent = Color(0x00000000);

  /// STATUS COLORS (kept natural)
  static const Color redColor = Color(0xFFEF5A57);
  static const Color cherryColor = Color(0xFFEF5A57);
  static const Color greenColor = Color(0xFF06A366);
  static const Color greenDeepColor = Color(0xFF008000);
  static const Color mintGreenColor = Color(0xFF5DB091);

  /// YELLOW / AMBER
  static const Color amberColor = Color(0xFFF2A43A);
  static const Color darkAmberColor = Color(0xFFE58E00);
  static const Color lightAmberColor = Color(0xFFF8C96A);
  static const Color yellowColor = Color(0xFFFFC30D);
  static const Color lightYellowColor = Color(0xFFFFF7E1);

  /// BACKGROUND SECTIONS (softer purples)
  static const Color selectedTabColor = Color(0xFFF3EDFF);
  static const Color totalOrderBGColor = Color(0xFFF2EEFF);
  static const Color pendingOrderBGColor = Color(0xFFEDEAFF);
  static const Color affiliateBonusBGColor = Color(0xFFFAF6FF);
  static const Color threeStepBGColor = Color(0xFFFAF6FF);
  static const Color productInfoBGColor = Color(0xFFF7F1FF);
  static const Color walletBalanceBGColor = Color(0xFFF8F1FF);
  static const Color successColor = Color(0xFFE9FCEB);
  static const Color errorColor = Color(0xFFEF5A57);

  /// ORANGE TONES
  static const Color ctaLight = Color(0xFFFDF1E3);
  static const Color LightOrange = Color(0xFFECCCA2);
  static const Color Orange = Color(0xFFD85F06);

  /// CARD COLOR
  static const Color CardColor = Color(0xFFF2F0FD);

  static const Color selectedBackground = Color(0xFF1D1E20);

  /// GRADIENTS
  static const LinearGradient strokeGradientColor = LinearGradient(
    colors: [
      Color(0xff9775FA),
      Color(0xff7048D4),
      Color(0xff5B34C9),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient appBGGradientColor = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.topLeft,
    colors: [
      Color(0xff9775FA),
      Color(0xff7F5AE5),
      Color(0xff7048D4),

    ],
  );

  static const LinearGradient CheckoutScreenContainerColor = LinearGradient(
    colors: [
      Color(0xff9775FA),
      Color(0xff7B53E7),
      Color(0xff7048D4),
    ],
    begin: Alignment.topLeft,
    end: Alignment.center,
  );
}
