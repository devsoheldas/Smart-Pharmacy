import 'package:e_pharma/core/constants/app_strings.dart';
import 'package:e_pharma/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_asset_paths.dart';
import '../../core/constants/app_colors.dart' as Colors;

class PaymentSuccessfulScreen extends StatefulWidget {
  final int orderId;
  final String? transactionId;
  final String? amount;

  const PaymentSuccessfulScreen({
    super.key,
    required this.orderId,
    this.transactionId,
    this.amount,
  });

  @override
  State<PaymentSuccessfulScreen> createState() => _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
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
                        Image.asset(
                          AssetPaths.PaymentSucessfulImage,
                          height: 90,
                          width: 60,
                          color: Colors.AppColors.greenColor,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppStrings.PaymentSuccessful,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppStrings.PaymentSuccessfulMassageOne,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.5),
                          ),
                        ),
                        Text(
                          AppStrings.PaymentSuccessfulMassageTwo,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  AppStrings.PaymentDetails,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.AppColors.blackColor.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ID',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.5),
                              ),
                            ),
                            Text(
                              '#${widget.orderId}',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),

                        if (widget.transactionId != null) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.PaymentDetailsTransactionID,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.5),
                                ),
                              ),
                              Text(
                                widget.transactionId!,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.PaymentDetailsTransactionDate,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.5),
                              ),
                            ),
                            Text(
                              _getCurrentDate(),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.PaymentDetailsTransactionTypeofTransaction,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.5),
                              ),
                            ),
                            Text(
                              'Cash on Delivery',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),

                        if (widget.amount != null) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.PaymentDetailsTransactionTotal,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.5),
                                ),
                              ),
                              Text(
                                '৳${widget.amount}',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.PaymentDetailsTransactionStatus,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.5),
                              ),
                            ),
                            Text(
                              'Confirmed',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.AppColors.greenColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.AppColors.LightOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.orderHistoryScreen,
                            (route) => false,
                      );
                    },
                    child: Text(AppStrings.TrackYourButton),
                  ),
                ),
                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.AppColors.Orange,
                      foregroundColor: Colors.AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.homeScreen,
                            (route) => false,
                      );
                    },
                    child: Text(AppStrings.BacktoHomeButton),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();

    return '${now.day},${now.month}, ${now.year}';
  }
}