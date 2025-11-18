import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/spacings/space.dart';
import 'package:e_pharma/core/utils/date_converter.dart';
import 'package:e_pharma/core/utils/toast_message.dart';
import 'package:e_pharma/core/widgets/app_button.dart';
import 'package:e_pharma/core/widgets/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<OrderItem> orders = [
    OrderItem(
      id: "989FD",
      name: "Doggesh",
      price: 504.80,
      qty: 1,
      status: OrderStatus.completed,
      date: DateTime.now(),
    ),
    OrderItem(
      id: "ORD772",
      name: "Doggesh",
      price: 501.80,
      qty: 1,
      status: OrderStatus.completed,
      date: DateTime.now(),
    ),
    OrderItem(
      id: "PEND01",
      name: "Doggesh",
      price: 504.80,
      qty: 1,
      status: OrderStatus.pending,
      date: DateTime.now(),
    ),
    OrderItem(
      id: "CANC01",
      name: "Doggesh",
      price: 504.80,
      qty: 1,
      status: OrderStatus.cancelled,
      date: DateTime.now(),
      cancelReason: "Changed my mind",
    ),
    OrderItem(
      id: "C02",
      name: "Doggesh",
      price: 899.99,
      qty: 1,
      status: OrderStatus.cancelled,
      date: DateTime.now(),
      cancelReason: "Found better price",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    _tabController.animation?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _cancelOrder(String orderId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          "Cancel Order?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          "This action cannot be undone.",
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          AppButton(
            title: 'No',
            height: 47,
            color: AppColors.greenColor,
            titleColor: AppColors.whiteColor,
            borderColor: AppColors.greenColor,
            onClick: (){
              Navigator.pop(context);
            },
          ),
          verticalSpacing(8),
          AppButton(
            title: "Yes, Cancel",
            height: 47,
            color: AppColors.redColor,
            titleColor: Colors.white,
            onClick: () {
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
              _tabController.animateTo(2);
              toastMessage(
                "Order cancelled",
                AppColors.greenColor,
                Colors.white,
                ToastGravity.BOTTOM,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWebOrTablet = ScreenUtil().screenWidth > 600;
    final cardWidth = isWebOrTablet ? 500.0 : double.infinity;
    final horizontalPadding = isWebOrTablet
        ? EdgeInsets.symmetric(
            horizontal: (ScreenUtil().screenWidth - cardWidth) / 2,
          )
        : EdgeInsets.zero;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CommonAppbar(title: "Order History"),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: _tabController.index == 0
                    ? AppColors.greenColor
                    : _tabController.index == 1
                    ? AppColors.amberColor
                    : AppColors.redColor,
                borderRadius: BorderRadius.circular(30),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textGreyColor,
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: "Completed"),
                Tab(text: "Pending"),
                Tab(text: "Cancelled"),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                3,
                (index) => _buildTabContent(
                  OrderStatus.values[index],
                  cardWidth,
                  horizontalPadding,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(
      OrderStatus status,
      double cardWidth,
      EdgeInsets padding,
      ) {
    final filtered = orders.where((o) => o.status == status).toList();
    if (filtered.isEmpty) return _buildEmptyState(status);

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: filtered.length,
      itemBuilder: (_, i) => Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12.h),
        child: InkWell(
          onTap: () {},
          child: _buildUnifiedCard(filtered[i]),
        ),
      ),
    );
  }


  Widget _buildUnifiedCard(OrderItem order) {
    final isCancelled = order.status == OrderStatus.cancelled;
    final isPending = order.status == OrderStatus.pending;

    final imageSize = ScreenUtil().screenWidth > 600 ? 90.0 : 70.0;

    return Card(
      elevation: 0,
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: AppColors.greyLight.withValues(alpha: 0.5), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().screenWidth > 600 ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#${order.id}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGreyColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isCancelled
                        ? AppColors.redColor.withValues(alpha: 0.1)
                        : isPending
                        ? AppColors.amberColor.withValues(alpha: 0.1)
                        : AppColors.greenColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    isCancelled
                        ? "Cancelled"
                        : isPending
                        ? "Pending"
                        : "Completed",
                    style: TextStyle(
                      color: isCancelled
                          ? AppColors.redColor
                          : isPending
                          ? AppColors.amberColor
                          : AppColors.greenColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            verticalSpacing(12),

            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://picsum.photos/id/237/200/300",
                    width: imageSize,
                    height: imageSize,
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
                      verticalSpacing(4),
                      Text(
                        "Quantity: ${order.qty}",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textGreyColor,
                        ),
                      ),
                      Text(
                        isCancelled
                            ? "Cancelled on ${getNormalDate(order.date.toIso8601String())}"
                            : "Ordered on ${getNormalDate(order.date.toIso8601String())}",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textGreyColor,
                        ),
                      ),
                      verticalSpacing(6),
                      Text(
                        "Price: ${order.price}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpacing(20),
            Row(
              children: [
                if (isPending)
                  Expanded(
                    child: AppButton(
                      title: "Cancel Order",
                      icon: Icons.close,
                      isNonFill: true,
                      borderColor: AppColors.redColor,
                      titleColor: AppColors.redColor,
                      height: 50,
                      onClick: () => _cancelOrder(order.id),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(OrderStatus status) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            status == OrderStatus.cancelled
                ? Icons.cancel_outlined
                : Icons.shopping_bag_outlined,
            size: 90,
            color: AppColors.greyLight,
          ),
          verticalSpacing(24),
          Text(
            "No ${status == OrderStatus.cancelled ? 'cancelled' : status.name.toLowerCase()} orders yet",
            style: TextStyle(fontSize: 18, color: AppColors.greyColor),
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

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.status,
    required this.date,
    this.cancelReason,
  });

  OrderItem copyWith({OrderStatus? status, String? cancelReason}) => OrderItem(
    id: id,
    name: name,
    price: price,
    qty: qty,
    status: status ?? this.status,
    date: date,
    cancelReason: cancelReason ?? this.cancelReason,
  );
}
