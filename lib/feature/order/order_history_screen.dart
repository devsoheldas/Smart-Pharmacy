import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/services/network/api_service.dart';
import 'package:e_pharma/core/spacings/space.dart';
import 'package:e_pharma/core/utils/date_converter.dart';
import 'package:e_pharma/core/utils/toast_message.dart';
import 'package:e_pharma/core/widgets/appbar/common_appbar.dart';
import 'package:e_pharma/core/models/order_response_model.dart';
import 'package:e_pharma/feature/order/order_details_screen.dart';
import 'package:e_pharma/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _selectedTab = 0;
  List<OrderData> orders = [];
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() => _isLoading = true);

    final response = await _apiService.getOrderList();

    if (response.success && response.data != null) {
      setState(() {
        orders = response.data!;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      toastMessage(
        response.message,
        AppColors.redColor,
        AppColors.whiteColor,
        ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> _cancelOrder(String orderId) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Cancel Order?"),
        content: Text("Are you sure you want to cancel this order? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No, Keep"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              final response = await _apiService.cancelOrder(orderId);

              if (response.success) {
                toastMessage(
                  response.message,
                  AppColors.greenColor,
                  AppColors.whiteColor,
                  ToastGravity.BOTTOM,
                );
                setState(() => _selectedTab = 2);
                _fetchOrders();
              } else {
                toastMessage(
                  response.message,
                  AppColors.redColor,
                  AppColors.whiteColor,
                  ToastGravity.BOTTOM,
                );
              }
            },
            child: Text("Yes, Cancel", style: TextStyle(color: AppColors.redColor)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenishWhite,
      appBar: CommonAppbar(
        title: "My Orders",
        isBackVisible: true,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildTabButton("Completed", 0, 8),
                horizontalSpacing(8),
                _buildTabButton("Pending", 1, 1),
                horizontalSpacing(8),
                _buildTabButton("Cancelled", 2, -1),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildTabContent(_getStatusForTab(_selectedTab)),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index, int statusCode) {
    final isSelected = _selectedTab == index;
    final color = _getColorForStatus(statusCode);

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: isSelected ? color : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? color : AppColors.greyLight,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.whiteColor : AppColors.textGreyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _getStatusForTab(int tab) {
    switch (tab) {
      case 0:
        return 8;
      case 1:
        return 1;
      case 2:
        return -1;
      default:
        return 8;
    }
  }

  Color _getColorForStatus(int status) {
    switch (status) {
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

  Widget _buildTabContent(int status) {
    final filtered = orders.where((o) => o.status == status).toList();
    if (filtered.isEmpty) return _buildEmptyState(status);

    return RefreshIndicator(
      onRefresh: _fetchOrders,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: filtered.length,
        itemBuilder: (_, i) => Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: _buildOrderCard(filtered[i]),
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderData order) {
    final color = _getColorForStatus(order.status ?? 0);
    final statusText = order.statusString ?? "Unknown";
    final statusIcon = _getStatusIcon(order.status ?? 0);
    final firstProduct = order.products?.isNotEmpty == true ? order.products!.first : null;
    final productImage = firstProduct?.modifiedImage ?? firstProduct?.image ?? "";
    final productName = firstProduct?.formattedName ?? firstProduct?.name ?? "Product";
    final quantity = firstProduct?.pivot?.quantity ?? 0;
    final price = firstProduct?.pivot?.unitPrice ?? "0";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order),
          ),
        ).then((_) => _fetchOrders());
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyLight),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(statusIcon, color: color, size: 18),
                      horizontalSpacing(8),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    order.orderId ?? "",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGreyColor,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          productImage,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 70,
                            height: 70,
                            color: AppColors.greyLight,
                            child: Icon(Icons.image, color: AppColors.textGreyColor),
                          ),
                        ),
                      ),
                      horizontalSpacing(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackLight,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalSpacing(6),
                            Text(
                              "Qty: $quantity • ৳$price",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textGreyColor,
                              ),
                            ),
                            verticalSpacing(6),
                            if (order.timelines?.isNotEmpty == true)
                              Text(
                                getNormalDate(order.timelines!.first.createdAt ?? ""),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textGreyColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(12),
                  Divider(height: 1, color: AppColors.greyLight),
                  verticalSpacing(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textGreyColor,
                            ),
                          ),
                          verticalSpacing(4),
                          Text(
                            "৳${order.totalAmount ?? '0'}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ],
                      ),
                      _buildActionButton(order),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(OrderData order) {
    if (order.status == 0 || order.status == 1) {
      return ElevatedButton(
        onPressed: () => _cancelOrder(order.orderId ?? ""),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.whiteColor,
          foregroundColor: AppColors.redColor,
          side: BorderSide(color: AppColors.redColor, width: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text("Cancel"),
      );
    } else if (order.status == 8) {
      return ElevatedButton(
        onPressed: () {
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenColor,
          foregroundColor: AppColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text("Reorder"),
      );
    } else {
      return Text(
        order.status == -1 ? "Cancelled" : "Processing",
        style: TextStyle(
          fontSize: 13,
          color: AppColors.textGreyColor,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  IconData _getStatusIcon(int status) {
    switch (status) {
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
        return Icons.access_time;
      case -1:
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
  Widget _buildEmptyState(int status) {
    final color = _getColorForStatus(status);
    final icon = _getStatusIcon(status);
    final statusText = status == 8 ? "Completed" : status == -1 ? "Cancelled" : "Pending";
    final title = "No $statusText Orders";
    final subtitle = "Your ${statusText.toLowerCase()} orders will appear here";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: color.withValues(alpha: 0.3),
          ),
          verticalSpacing(16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.blackLight,
            ),
          ),
          verticalSpacing(8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textGreyColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}