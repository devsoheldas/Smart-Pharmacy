import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/spacings/space.dart';
import 'package:e_pharma/core/utils/date_converter.dart';
import 'package:e_pharma/core/widgets/appbar/common_appbar.dart';
import 'package:e_pharma/feature/order/order_history_screen.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderItem order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenishWhite,
      appBar: const CommonAppbar(title: "Order Details"),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 120),
            children: [
              _buildStatusBadge(),
              verticalSpacing(20),
              _buildOrderInfoCard(),
              verticalSpacing(16),
              _buildReceiverInfoCard(),
              verticalSpacing(16),
              _buildPaymentCard(),
              verticalSpacing(16),
              _buildProductCard(),
              verticalSpacing(30),
            ],
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (order.status) {
      case OrderStatus.completed:
        return AppColors.greenColor;
      case OrderStatus.pending:
        return AppColors.amberColor;
      case OrderStatus.cancelled:
        return AppColors.redColor;
    }
  }

  String _getStatusText() {
    switch (order.status) {
      case OrderStatus.completed:
        return "Order Completed";
      case OrderStatus.pending:
        return "Order Processing";
      case OrderStatus.cancelled:
        return "Order Cancelled";
    }
  }

  IconData _getStatusIcon() {
    switch (order.status) {
      case OrderStatus.completed:
        return Icons.check_circle;
      case OrderStatus.pending:
        return Icons.access_time_rounded;
      case OrderStatus.cancelled:
        return Icons.cancel_rounded;
    }
  }

  Widget _buildStatusBadge() {
    final statusColor = _getStatusColor();

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_getStatusIcon(), color: AppColors.whiteColor, size: 20),
            horizontalSpacing(8),
            Text(
              _getStatusText(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            "Order ID",
            order.orderId,
            "Order Date",
            getNormalDate(order.orderDate.toIso8601String()),
            isWhiteText: true,
          ),
          verticalSpacing(16),
          _buildInfoRow(
            "Tracking ID",
            order.trackingId,
            "Delivered On",
            order.orderDeliveredDate != null
                ? getNormalDate(order.orderDeliveredDate!.toIso8601String())
                : "Not Delivered Yet",
            isWhiteText: true,
          ),
        ],
      ),
    );
  }

  Widget _buildReceiverInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.person_outline, color: AppColors.whiteColor, size: 20),
                horizontalSpacing(12),
                Text(
                  "Receiver Info",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoItem("Name", order.receiverName, Icons.badge),
                _buildInfoItem("Address", order.receiverAddress, Icons.location_on),
                _buildInfoItem("Phone no.", order.receiverPhone, Icons.phone),
                _buildInfoItem("Email", order.receiverEmail, Icons.email),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard() {
    final icon = order.paymentMethod.toLowerCase().contains('card')
        ? Icons.credit_card
        : order.paymentMethod.toLowerCase().contains('cash')
        ? Icons.money
        : Icons.account_balance_wallet;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.amberColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.payment, color: AppColors.whiteColor, size: 20),
                horizontalSpacing(12),
                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.amberColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 24, color: AppColors.amberColor),
                ),
                horizontalSpacing(16),
                Expanded(
                  child: Text(
                    order.paymentMethod,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.mediumBlueColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.shopping_bag_outlined, color: AppColors.whiteColor, size: 20),
                horizontalSpacing(12),
                Text(
                  "Product",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    order.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                horizontalSpacing(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpacing(6),
                      Text(
                        order.productDetails,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textGreyColor,
                        ),
                      ),
                      verticalSpacing(10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "\$${order.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      String label1,
      String value1,
      String label2,
      String value2, {
        bool isWhiteText = false,
      }) {
    final labelColor = isWhiteText
        ? AppColors.whiteColor.withValues(alpha: 0.85)
        : AppColors.textGreyColor;
    final valueColor = isWhiteText ? AppColors.whiteColor : AppColors.blackLight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: TextStyle(
                  fontSize: 13,
                  color: labelColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpacing(6),
              Text(
                value1,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                label2,
                style: TextStyle(
                  fontSize: 13,
                  color: labelColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpacing(6),
              Text(
                value2,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.greenColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColors.greenColor),
          ),
          horizontalSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textGreyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpacing(2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textGreyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpacing(4),
                Text(
                  "\$${order.totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.refresh, size: 20),
              label: Text("Reorder"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}