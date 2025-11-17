import 'package:flutter/material.dart';
import '../../core/constants/app_asset_paths.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isSwitch = false;
  String? isRadio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          AppStrings.CheckoutScreenAppbarTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.CheckoutScreenBodyHeadTitle,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Card(
                  color: AppColors.CardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  // color: Colors.grey,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      child: Transform.scale(
                        scale: 0.5,
                        child: Switch(
                          value: isSwitch,
                          onChanged: (value) {
                            setState(() {
                              isSwitch = value;
                            });
                          },
                        ),
                      ),
                    ),
                    title: Text(
                      AppStrings.CheckoutScreenCardOneTitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Radio(
                      value: "yes",
                      groupValue: isRadio,
                      onChanged: (value) {
                        setState(() {
                          isRadio = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  color: AppColors.CardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.paypal_outlined,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      AppStrings.CheckoutScreenCardTwoTitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Radio(
                      value: "no",
                      groupValue: isRadio,
                      onChanged: (value) {
                        setState(() {
                          isRadio = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  color: AppColors.CardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  // color: AppColors.blackColor,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.more_vert, color: Colors.black),
                    ),
                    title: Text(
                      AppStrings.CheckoutScreenCardThirdTitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: AppColors.CheckoutScreenContainerColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.CheckoutScreenContainerTextone,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Transform.scale(
                              scale: 0.5,
                              child: Switch(
                                value: isSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitch = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          width: 60,
                          child: Image.asset(AssetPaths.SimeCard),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(AppStrings.CheckoutScreenContainerTexttwo),
                            Text(AppStrings.CheckoutScreenContainerTexttwo),
                            Text(AppStrings.CheckoutScreenContainerTexttwo),
                            Text(AppStrings.CheckoutScreenContainerTexttwo),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.CheckoutScreenContainerTextthird1,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(fontSize: 12),
                            ),
                            Text(
                              AppStrings.CheckoutScreenContainerTextthird2,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.grey.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.CheckoutScreenCardForthTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          AppStrings.CheckoutScreenCardForthTraling,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(fontSize: 12,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(AppStrings.CheckoutScreenPayButton),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
