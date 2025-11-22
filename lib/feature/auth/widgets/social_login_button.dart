import 'package:flutter/material.dart';

import '../../../core/constants/app_asset_paths.dart';
class SocialLoginButton extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child:
        Center(
          child: Image.asset(
            image,
            width: 20,
            height: 20,
          ),
      ),
    ));
  }
}