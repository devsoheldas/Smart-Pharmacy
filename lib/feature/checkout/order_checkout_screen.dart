import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/services/network/api_service.dart';
import 'package:e_pharma/feature/checkout/payment_succesful_screen.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';


class OrderCheckoutScreen extends StatefulWidget {
  final String orderId;
  final int addressId;

  const OrderCheckoutScreen({
    super.key,
    required this.orderId,
    required this.addressId,
  });

  @override
  State<OrderCheckoutScreen> createState() => _OrderCheckoutScreenState();
}

class _OrderCheckoutScreenState extends State<OrderCheckoutScreen> {
  final ApiService _apiService = ApiService();

  String? selectedPayment = 'cod';
  bool _isProcessing = false;

  Future<void> _confirmOrder() async {
    if (_isProcessing) return;

    if (selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);


    try {
      final updateResponse = await _apiService.updateOrderAddress(
        orderId: widget.orderId,
        addressId: widget.addressId,
        deliveryType: 'standard',
      );

      if (!updateResponse.success) {
        if (!mounted) return;
        Navigator.pop(context);
        _showError(updateResponse.message);
        setState(() => _isProcessing = false);
        return;
      }


      final confirmResponse = await _apiService.confirmOrder(
        orderId: widget.orderId,
        paymentMethod: selectedPayment!,
      );

      if (!mounted) return;
      Navigator.pop(context);

      if (confirmResponse.success) {
        final data = confirmResponse.data?.data;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentSuccessfulScreen(
              orderId: int.tryParse(widget.orderId) ?? 0,
              transactionId: data?.transactionId,
              amount: data?.amount,
            ),
          ),
        );
      } else {
        _showError(confirmResponse.message);
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      _showError('An error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: AppColors.primaryColor)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
                  'Order Summary',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  color: AppColors.CardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ID',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              '#${widget.orderId}',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              'Standard (Free)',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.greenColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),


                Text(
                  AppStrings.CheckoutScreenBodyHeadTitle,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),


                Card(
                  color: AppColors.CardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.money,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Cash on Delivery',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text('Pay when you receive'),
                    trailing: Radio(
                      value: "cod",
                      groupValue: selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                Card(
                  color: AppColors.CardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone_android,
                      color: Colors.pink,
                    ),
                    title: Text(
                      'bKash',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text('Not available'),
                    trailing: Radio(
                      value: "bkash",
                    ),
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 5),

                Card(
                  color: AppColors.CardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.orange,
                    ),
                    title: Text(
                      'Nagad',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text('Not available'),
                    trailing: Radio(
                      value: "nagad",
                    ),
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 20),


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
                          'Payment Method',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          selectedPayment == 'cod' ? 'Cash on Delivery' : 'Not Selected',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greenColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),

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
                    onPressed: _isProcessing ? null : _confirmOrder,
                    child: _isProcessing
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text('Confirm Order'),
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