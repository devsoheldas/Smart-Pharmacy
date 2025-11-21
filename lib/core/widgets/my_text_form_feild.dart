import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MyTextFormFeild extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const MyTextFormFeild({
    super.key,
     required this.hintText,
    this.controller,
    this.keyboardType,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blackColor,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: AppColors.blackColor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.blackColor,
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.blackColor,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.blackColor,
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.redColor,
              )
          )
      ),
    );
  }
}
