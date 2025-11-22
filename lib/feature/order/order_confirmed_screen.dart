
import 'package:e_pharma/core/constants/app_asset_paths.dart';
import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/constants/app_strings.dart';
import 'package:e_pharma/core/widgets/my_text_form_feild.dart';
import 'package:flutter/material.dart';

class OrderConfirmedScreen extends StatefulWidget {
  const OrderConfirmedScreen({super.key});

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child:  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.greenDeepColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.TotalOrder,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                              fontSize: 14,
                            ),),
                            Text(AppStrings.TotalOrderValue,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                              fontSize: 14,
                            ),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(AppStrings.PersonalInformation,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),),
                    SizedBox(height: 15,),
                    MyTextFormFeild(
                        hintText: "Your Name"
                    ),
                    SizedBox(height: 10,),
                    MyTextFormFeild(
                        hintText: "Your Email Address"
                    ),
                    SizedBox(height: 10,),
                    MyTextFormFeild(
                        hintText: "Your Phone Number"
                    ),
                    SizedBox(height: 10,),
                    MyTextFormFeild(
                        hintText: "Shipping Address"
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AppStrings.DeliveryType,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                          fontSize: 14,
                        ),),
                        Row(
                          children: [
                            Radio(value: false),
                            SizedBox(width: 3,),
                            Text(AppStrings.DeliveryTypeExpress,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(value: false),
                            SizedBox(width: 3,),
                            Text(AppStrings.DeliveryTypeNormal,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AppStrings.DeliveryMethod,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                          fontSize: 14,
                        ),),
                        Row(
                          children: [
                            Radio(value: false),
                            SizedBox(width: 3,),
                            Text(AppStrings.CashOnDelivery,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(value: false),
                            SizedBox(width: 3,),
                            Text(AppStrings.DigitalPayment,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(value: false),
                            SizedBox(width: 3,),
                            SizedBox(
                                height: 60,
                                width: 40,
                                child: Image.asset(AssetPaths.Bikash_icon))
                          ],
                        ),
                        Row(
                          children: [
                            Radio(value: false),
                            SizedBox(width: 3,),
                            SizedBox(
                                height: 60,
                                width: 40,
                                child: Image.asset(AssetPaths.Nogod_Icon))
                          ],
                        ),
                        Row(
                          children: [
                            Radio(value: false),
                            SizedBox(width: 3,),
                            SizedBox(
                                height: 60,
                                width: 40,
                                child: Image.asset(AssetPaths.Dutch_Bangla_roket))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greenDeepColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          onPressed: (){}, child: Text(AppStrings.ConfirmedOrder,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                        fontSize: 14,
                      ),)),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
