import 'package:e_pharma/core/constants/app_asset_paths.dart';
import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackVisible;

  const CommonAppbar({
    super.key,
    required this.title,
    this.isBackVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.PADDING_SIZE_DEFAULT.w,
          vertical: AppDimensions.PADDING_SIZE_DEFAULT.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Centered title
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.blackLight,
                  fontSize: AppDimensions.FONT_SIZE_OVER_LARGE.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              /// Back button if visible
              if (isBackVisible)
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: SvgPicture.asset(
                      AssetPaths.back_button,
                      width: AppDimensions.IMAGE_SIZE_45.h,
                      height: AppDimensions.IMAGE_SIZE_45.h,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10.0);
}
