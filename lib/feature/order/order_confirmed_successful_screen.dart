import 'package:e_pharma/core/constants/app_asset_paths.dart';
import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/constants/app_strings.dart';
import 'package:e_pharma/core/spacings/space.dart';
import 'package:flutter/material.dart';

class OrderConfirmedSuccessfulScreen extends StatefulWidget {
  const OrderConfirmedSuccessfulScreen({super.key});

  @override
  State<OrderConfirmedSuccessfulScreen> createState() => _OrderConfirmedSuccessfulScreenState();
}

class _OrderConfirmedSuccessfulScreenState extends State<OrderConfirmedSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 80,
                width: 60,
                child: Image.asset(AssetPaths.Order_Confirmed)),
            verticalSpacing(10),
            Text(AppStrings.OrderConfirmed,style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              fontSize: 22,
            ),),
            verticalSpacing(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.OrderSuccesfullyMassage,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                  fontSize: 14,
                ),),
                Text(AppStrings.OrderHistory,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.greenColor,
                  fontSize: 16,
                ),),
              ],
            ),
            verticalSpacing(5),
            Text(AppStrings.OrderTime,style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
              fontSize: 14,
            ),),
            verticalSpacing(25),
            SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: (){}, child: Text(AppStrings.TrackMyOrder,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.greenDeepColor,
                fontSize: 16,
              ),)),
            ),
            verticalSpacing(35),
            SizedBox(
              height: 40,
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenDeepColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  onPressed: (){}, child: Text(AppStrings.ContinueShopping,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
                fontSize: 16,
              ),)),
            ),
          ],
        ),
      ),
    );
  }
}
