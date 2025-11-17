import 'package:e_pharma/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_asset_paths.dart';
import '../../core/constants/app_colors.dart' as Colors;


class PaymentSuccesfulScreen extends StatefulWidget {
  const PaymentSuccesfulScreen({super.key});

  @override
  State<PaymentSuccesfulScreen> createState() => _PaymentSuccesfulScreenState();
}

class _PaymentSuccesfulScreenState extends State<PaymentSuccesfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(AssetPaths.PaymentSucessfulImage,
                          height: 90,
                          width: 60,
                          color: Colors.AppColors.greenColor,
                        ),
                        SizedBox(height: 5,),
                        Text(AppStrings.PaymentSuccessful,style: Theme.of(context).textTheme.titleMedium,),
                        SizedBox(height: 5,),
                        Text(AppStrings.PaymentSuccessfulMassageOne,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
                        ),),
                        Text(AppStrings.PaymentSuccessfulMassageTwo,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Text(AppStrings.PaymentDetails, style: Theme.of(context).textTheme.bodySmall!.copyWith(
                 fontWeight: FontWeight.w600,
                ),),
                SizedBox(height: 5,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.AppColors.blackColor.withOpacity(0.3),
                      width: 1
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text( AppStrings.PaymentDetailsTransactionID,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(AppStrings.TransactionID,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.PaymentDetailsTransactionDate,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(AppStrings.TransactionDate,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.PaymentDetailsTransactionTypeofTransaction,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(AppStrings.TypeofTransaction,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.PaymentDetailsTransactionTotal,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(AppStrings.TransactionTotal,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.PaymentDetailsTransactionStatus,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(AppStrings.TransactionStatus,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.AppColors.greenColor
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.AppColors.LightOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      )
                    ),
                      onPressed: (){}, child: Text(AppStrings.TrackYourButton)),
                ),
                SizedBox(height: 25,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.AppColors.Orange,
                        foregroundColor: Colors.AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )
                      ),
                      onPressed: (){}, child: Text(AppStrings.BacktoHomeButton)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
