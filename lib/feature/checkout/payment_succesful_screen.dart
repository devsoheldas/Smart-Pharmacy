import 'package:flutter/material.dart';
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
                        Image.asset("assets/images/Successful_image.png",
                          height: 90,
                          width: 60,
                          color: Colors.AppColors.greenColor,
                        ),
                        SizedBox(height: 5,),
                        Text("Payment Successful",style: Theme.of(context).textTheme.titleMedium,),
                        SizedBox(height: 5,),
                        Text("Payment Successful! Thanks for your ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
                        ),),
                        Text("order - it's now confirmed.",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Text("Payment Details", style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                            Text(" Transaction ID ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(" 4051 3543 1002 ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(" Date ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(" 1 April 2025 ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(" Type of Transaction ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(" Master Card ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(" Total ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(" \$27.59 ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("  Status ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5),
                            ),),
                            Text(" Success ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                      onPressed: (){}, child: Text("Track Your Order")),
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
                      onPressed: (){}, child: Text("Back to Home")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
