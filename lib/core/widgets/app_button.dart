import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/constants/app_dimensions.dart';
import 'package:e_pharma/core/spacings/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onClick;

  final bool isNonFill;
  final EdgeInsets margin;
  final Color color;
  final Color titleColor;
  final Color borderColor;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final Color iconColor;
  final bool? isDisabled;
  final double borderRadius;

  AppButton({
    super.key,
    required this.title,
    required this.onClick,
    this.icon,
    bool? isNonFill,
    EdgeInsets? margin,
    Color? color,
    Color? titleColor,
    Color? borderColor,
    Color? iconColor,
    double? width,
    double? height,
    double? fontSize,
    FontWeight? fontWeight,
    this.isDisabled,
    double? borderRadius,
  })  : isNonFill = isNonFill ?? false,
        margin = margin ?? AppDimensions.appMarginHorizontal,
        width = width ?? double.infinity,
        height = height ?? AppDimensions.appButtonHeight,
        fontSize = fontSize ?? AppDimensions.fontButtonSize,
        fontWeight = fontWeight ?? FontWeight.w400,
        color = color ?? AppColors.primaryColor,
        titleColor = titleColor ?? AppColors.whiteColor,
        borderColor = borderColor ?? AppColors.primaryColor,
        iconColor = iconColor ?? AppColors.whiteColor,
        borderRadius = borderRadius ?? AppDimensions.appButtonRadius;

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled ?? false;

    return Container(
      margin: margin,
      width: width.w,
      height: height.h,
      child: MaterialButton(
        disabledColor: AppColors.greyLight,
        onPressed: disabled ? null : () => onClick(),
        elevation: 0,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: disabled ? AppColors.greyColor : borderColor,
            width: 1,
          ),
        ),
        color: disabled
            ? AppColors.greyColor
            : (isNonFill ? AppColors.whiteColor : color),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: disabled ? AppColors.greyColor : iconColor,
                  size: AppDimensions.appButtonIconSize,
                ),
                horizontalSpacing(8),
              ],
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: disabled ? AppColors.greyColor : titleColor, fontSize: fontSize, fontWeight: fontWeight)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
