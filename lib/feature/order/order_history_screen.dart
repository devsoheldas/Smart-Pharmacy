import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/spacings/space.dart';
import 'package:e_pharma/core/utils/date_converter.dart';
import 'package:e_pharma/core/utils/toast_message.dart';
import 'package:e_pharma/core/widgets/appbar/common_appbar.dart';
import 'package:e_pharma/feature/order/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _selectedTab = 0;

  final List<OrderItem> orders = [
    OrderItem(
      id: "87SDF",
      name: "Napa",
      price: 50.00,
      qty: 1,
      status: OrderStatus.completed,
      date: DateTime.now().subtract(const Duration(days: 30)),
      orderId: "#ORD-2025-001",
      orderDate: DateTime.now(),
      orderDeliveredDate: DateTime.now(),
      trackingId: "#BC67584",
      receiverName: "Sohel Das",
      receiverAddress: "shabar,Canada",
      receiverPhone: "+8804321432",
      receiverEmail: "soheldas@gmail.com",
      paymentMethod: "Bow er jonno nice tai free",
      totalAmount: 24.99,
      productDetails: "100 unit",
      imageUrl: "https://picsum.photos/200",
    ),
    OrderItem(
      id: "T43TS",
      name: "Napa extra",
      price: 501.80,
      qty: 1,
      status: OrderStatus.pending,
      date: DateTime.now().subtract(const Duration(days: 15)),
      orderId: "#ORD-2025-002",
      orderDate: DateTime.now(),
      orderDeliveredDate: DateTime.now(),
      trackingId: "#BC67585",
      receiverName: "Arafat",
      receiverAddress: "Arafat er Basay.",
      receiverPhone: "+880198743873",
      receiverEmail: "arafat@gmail.com",
      paymentMethod: "Visa **** **** **** 4567",
      totalAmount: 501.80,
      productDetails: "1 unit",
      imageUrl: "https://picsum.photos/200",
    ),
    OrderItem(
      id: "FD3FAF",
      name: "Vitamin",
      price: 125.50,
      qty: 2,
      status: OrderStatus.pending,
      date: DateTime.now().subtract(const Duration(days: 2)),
      orderId: "#ORD-2025-003",
      orderDate: DateTime.now(),
      orderDeliveredDate: null,
      trackingId: "#BC67586",
      receiverName: "Sohan & Naim",
      receiverAddress: "No location ",
      receiverPhone: "+08843812764",
      receiverEmail: "nomail@nomail.mail",
      paymentMethod: "bkash 017******43",
      totalAmount: 251.00,
      productDetails: "2 units",
      imageUrl: "https://picsum.photos/200",
    ),
    OrderItem(
      id: "F432R",
      name: "Napa 3 bela",
      price: 320.00,
      qty: 1,
      status: OrderStatus.cancelled,
      date: DateTime.now().subtract(const Duration(days: 7)),
      orderId: "#ORD-2025-004",
      orderDate: DateTime.now(),
      orderDeliveredDate: null,
      trackingId: "#BC67587",
      receiverName: "Ami nije",
      receiverAddress: "jani naa",
      receiverPhone: "87231894",
      receiverEmail: "ismail@gmail.hk",
      paymentMethod: "No payment for free",
      totalAmount: 320.00,
      productDetails: "1 unit",
      imageUrl: "https://picsum.photos/200",
    ),
  ];

  void _cancelOrder(String orderId) {
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
            onPressed: () {
              setState(() {
                final i = orders.indexWhere((e) => e.id == orderId);
                if (i != -1) {
                  orders[i] = orders[i].copyWith(
                    status: OrderStatus.cancelled,
                    cancelReason: "Cancelled by user",
                  );
                }
              });
              Navigator.pop(context);
              setState(() => _selectedTab = 2);
              toastMessage(
                "Order cancelled successfully",
                AppColors.greenColor,
                AppColors.whiteColor,
                ToastGravity.BOTTOM,
              );
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
      appBar: const CommonAppbar(title: "My Orders"),
      body: Column(
        children: [
          Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildTabButton("Completed", 0, OrderStatus.completed),
                horizontalSpacing(8),
                _buildTabButton("Pending", 1, OrderStatus.pending),
                horizontalSpacing(8),
                _buildTabButton("Cancelled", 2, OrderStatus.cancelled),
              ],
            ),
          ),
          Expanded(
            child: _buildTabContent(_getStatusForTab(_selectedTab)),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index, OrderStatus status) {
    final isSelected = _selectedTab == index;
    final color = _getColorForStatus(status);

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

  OrderStatus _getStatusForTab(int tab) {
    switch (tab) {
      case 0:
        return OrderStatus.completed;
      case 1:
        return OrderStatus.pending;
      case 2:
        return OrderStatus.cancelled;
      default:
        return OrderStatus.completed;
    }
  }

  Color _getColorForStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return AppColors.greenColor;
      case OrderStatus.pending:
        return AppColors.amberColor;
      case OrderStatus.cancelled:
        return AppColors.redColor;
    }
  }

  Widget _buildTabContent(OrderStatus status) {
    final filtered = orders.where((o) => o.status == status).toList();
    if (filtered.isEmpty) return _buildEmptyState(status);

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (_, i) => Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: _buildOrderCard(filtered[i]),
      ),
    );
  }

  Widget _buildOrderCard(OrderItem order) {
    final color = _getColorForStatus(order.status);
    final statusText = _getStatusText(order.status);
    final statusIcon = _getStatusIcon(order.status);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order),
          ),
        );
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
            // Header
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
                    "#${order.id}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGreyColor,
                    ),
                  ),
                ],
              ),
            ),

            // Content
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
                          order.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      horizontalSpacing(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.name,
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
                              "Qty: ${order.qty} • \$${order.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textGreyColor,
                              ),
                            ),
                            verticalSpacing(6),
                            Text(
                              getNormalDate(order.date.toIso8601String()),
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
                            "\$${order.totalAmount.toStringAsFixed(2)}",
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

  Widget _buildActionButton(OrderItem order) {
    if (order.status == OrderStatus.pending) {
      return ElevatedButton(
        onPressed: () => _cancelOrder(order.id),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.whiteColor,
          foregroundColor: AppColors.redColor,
          side: BorderSide(color: AppColors.redColor, width: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text("Cancel"),
      );
    } else if (order.status == OrderStatus.completed) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenColor,
          foregroundColor: AppColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text("Reorder"),
      );
    } else {
      return Text(
        "Refunded",
        style: TextStyle(
          fontSize: 13,
          color: AppColors.textGreyColor,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return "Delivered";
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.cancelled:
        return "Cancelled";
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return Icons.check_circle;
      case OrderStatus.pending:
        return Icons.access_time;
      case OrderStatus.cancelled:
        return Icons.cancel;
    }
  }

  Widget _buildEmptyState(OrderStatus status) {
    final color = _getColorForStatus(status);
    final icon = _getStatusIcon(status);
    final title = "No ${_getStatusText(status)} Orders";
    final subtitle = "Your ${_getStatusText(status).toLowerCase()} orders will appear here";

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

enum OrderStatus { completed, pending, cancelled }

class OrderItem {
  final String id, name;
  final double price;
  final int qty;
  final OrderStatus status;
  final DateTime date;
  final String? cancelReason;
  final String orderId;
  final DateTime orderDate;
  final DateTime? orderDeliveredDate;
  final String trackingId;
  final String receiverName;
  final String receiverAddress;
  final String receiverPhone;
  final String receiverEmail;
  final String paymentMethod;
  final double totalAmount;
  final String productDetails;
  final String imageUrl;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.status,
    required this.date,
    this.cancelReason,
    required this.orderId,
    required this.orderDate,
    this.orderDeliveredDate,
    required this.trackingId,
    required this.receiverName,
    required this.receiverAddress,
    required this.receiverPhone,
    required this.receiverEmail,
    required this.paymentMethod,
    required this.totalAmount,
    required this.productDetails,
    required this.imageUrl,
  });

  OrderItem copyWith({OrderStatus? status, String? cancelReason}) => OrderItem(
    id: id,
    name: name,
    price: price,
    qty: qty,
    status: status ?? this.status,
    date: date,
    cancelReason: cancelReason ?? this.cancelReason,
    orderId: orderId,
    orderDate: orderDate,
    orderDeliveredDate: orderDeliveredDate,
    trackingId: trackingId,
    receiverName: receiverName,
    receiverAddress: receiverAddress,
    receiverPhone: receiverPhone,
    receiverEmail: receiverEmail,
    paymentMethod: paymentMethod,
    totalAmount: totalAmount,
    productDetails: productDetails,
    imageUrl: imageUrl,
  );
}