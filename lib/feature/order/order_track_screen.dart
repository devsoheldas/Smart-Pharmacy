import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/widgets/time_line_widget.dart';
import 'package:flutter/material.dart';

class OrderTrackScreen extends StatefulWidget {
  const OrderTrackScreen({super.key});

  @override
  State<OrderTrackScreen> createState() => _OrderTrackScreenState();
}

class _OrderTrackScreenState extends State<OrderTrackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.pendingOrderBGColor,
        title: Text("Order Tracking "),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: const [
                    TimeLineItem(
                      title: "Ordered",
                      description: "You placed an order successfully.",
                      time: "10:00 AM, 21 Nov 2025",
                      icon: Icons.shopping_cart,
                      lineColor: AppColors.greenColor,
                    ),
                    TimeLineItem(
                      title: "Order confirmed",
                      description: "Your order is being prepared.",
                      time: "11:00 AM, 21 Nov 2025",
                      icon: Icons.confirmation_num_outlined,
                      lineColor: AppColors.Orange,
                    ),
                    TimeLineItem(
                      title: " Order Shipped",
                      description: "Your package is on its way.",
                      time: "1:30 PM, 21 Nov 2025",
                      icon: Icons.local_shipping,
                      lineColor: AppColors.blue,
                    ),
                    TimeLineItem(
                      title: " Delivered",
                      description: "Your package is on its way.",
                      time: "1:30 PM, 21 Nov 2025",
                      icon: Icons.delivery_dining_sharp,
                      lineColor: AppColors.blackColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
