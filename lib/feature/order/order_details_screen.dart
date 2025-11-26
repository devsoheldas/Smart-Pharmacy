import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/services/network/api_service.dart';
import 'package:e_pharma/core/spacings/space.dart';
import 'package:e_pharma/core/utils/date_converter.dart';
import 'package:e_pharma/core/widgets/appbar/common_appbar.dart';
import 'package:e_pharma/core/models/order_response_model.dart';
import 'package:e_pharma/core/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderData order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderData _order;
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    setState(() => _isLoading = true);

    final response = await _apiService.getOrderDetails(_order.orderId ?? "");

    if (response.success && response.data != null) {
      setState(() {
        _order = response.data!;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenishWhite,
      appBar: const CommonAppbar(title: "Order Details"),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
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
              _buildProductsCard(),
              verticalSpacing(16),
              if (_order.timelines?.isNotEmpty == true)
              verticalSpacing(30),
            ],
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (_order.status) {
      case 8:
        return AppColors.greenColor;
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        return AppColors.amberColor;
      case -1:
      case -2:
        return AppColors.redColor;
      default:
        return AppColors.greyLight;
    }
  }

  String _getStatusText() {
    return _order.statusString ?? "Unknown";
  }

  IconData _getStatusIcon() {
    switch (_order.status) {
      case 8:
        return Icons.check_circle;
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        return Icons.access_time_rounded;
      case -1:
      case -2:
        return Icons.cancel_rounded;
      default:
        return Icons.info;
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
    final createdTimeline = _order.timelines?.firstWhere(
          (t) => t.status == 0,
      orElse: () => Timeline(),
    );

    final createdDate = createdTimeline?.actualCompletionTime != null
        ? getNormalDate(createdTimeline!.actualCompletionTime!)
        : "N/A";

    final deliveredTimeline = _order.timelines?.firstWhere(
          (t) => t.status == 8,
      orElse: () => Timeline(),
    );

    final deliveredDate = deliveredTimeline?.actualCompletionTime != null
        ? getNormalDate(deliveredTimeline!.actualCompletionTime!)
        : "Not Delivered Yet";

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
            _order.orderId ?? "N/A",
            "Order Date",
            createdDate,
            isWhiteText: true,
          ),
          verticalSpacing(16),
          _buildInfoRow(
            "Delivery Type",
            _order.deliveryType ?? "N/A",
            "Delivered On",
            deliveredDate,
            isWhiteText: true,
          ),
        ],
      ),
    );
  }

  Widget _buildReceiverInfoCard() {
    final address = _order.address;
    final customer = _order.customer;

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
                _buildInfoItem("Name", customer?.name ?? address?.name?.toString() ?? "N/A", Icons.badge),
                _buildInfoItem("Address", address?.address ?? "N/A", Icons.location_on),
                _buildInfoItem("Phone no.", customer?.phone ?? address?.phone?.toString() ?? "N/A", Icons.phone),
                if (address?.city != null)
                  _buildInfoItem("City", address!.city!, Icons.location_city),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard() {
    final payment = _order.payments?.isNotEmpty == true ? _order.payments!.first : null;
    final paymentMethod = payment?.paymentMethod ?? "N/A";

    final icon = paymentMethod.toLowerCase().contains('card') || paymentMethod.toLowerCase().contains('visa')
        ? Icons.credit_card
        : paymentMethod.toLowerCase().contains('cash') || paymentMethod.toLowerCase().contains('cod')
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paymentMethod,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackLight,
                        ),
                      ),
                      if (payment?.transactionId != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            "Trans ID: ${payment!.transactionId}",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textGreyColor,
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

  Widget _buildProductsCard() {
    final products = _order.products ?? [];

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
                  "Products (${products.length})",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (_, __) => Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: AppColors.greyLight),
            ),
            itemBuilder: (_, index) {
              final product = products[index];
              final imageUrl = product.modifiedImage ?? product.image ?? "https://via.placeholder.com/200";
              final name = product.formattedName ?? product.name ?? "Product";
              final quantity = product.pivot?.quantity ?? 0;
              final unitPrice = product.pivot?.unitPrice ?? "0";
              final totalPrice = product.pivot?.totalPrice ?? "0";
              final strengthInfo = product.strengthInfo ?? "";

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        color: AppColors.greyLight,
                        child: Icon(Icons.image, color: AppColors.textGreyColor),
                      ),
                    ),
                  ),
                  horizontalSpacing(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackLight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (strengthInfo.isNotEmpty) ...[
                          verticalSpacing(4),
                          Text(
                            strengthInfo,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textGreyColor,
                            ),
                          ),
                        ],
                        verticalSpacing(6),
                        Text(
                          "Qty: $quantity × ৳$unitPrice",
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
                            "৳$totalPrice",
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
              );
            },
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
                  "৳${_order.totalAmount ?? '0'}",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
              },
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