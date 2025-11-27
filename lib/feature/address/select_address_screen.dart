import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/models/address_response_model.dart';
import 'package:e_pharma/core/services/network/api_service.dart';
import 'package:e_pharma/feature/checkout/order_checkout_screen.dart'; // FIXED: Changed from checkout_screen.dart
import 'package:flutter/material.dart';
import 'add_address_screen.dart';

class SelectAddressScreen extends StatefulWidget {
  final String orderId;

  const SelectAddressScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  final ApiService _addressService = ApiService();
  List<AddressData> addresses = [];
  bool isLoading = true;
  String? errorMessage;
  int? selectedAddressId;

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  Future<void> _fetchAddresses() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final response = await _addressService.getAllAddresses();

    setState(() {
      isLoading = false;
      if (response.success) {
        addresses = response.data ?? [];
        // Auto-select default address if available
        final defaultAddress = addresses.firstWhere(
              (addr) => addr.isDefault == 1,
          orElse: () => addresses.isNotEmpty ? addresses.first : AddressData(),
        );
        if (defaultAddress.id != null) {
          selectedAddressId = defaultAddress.id;
        }
      } else {
        errorMessage = response.message;
      }
    });
  }

  void _proceedToCheckout() {
    if (selectedAddressId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a delivery address'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderCheckoutScreen(
          orderId: widget.orderId,
          addressId: selectedAddressId!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text(
          "Select Delivery Address",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchAddresses,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? _buildErrorState()
          : addresses.isEmpty
          ? _buildEmptyState()
          : _buildAddressList(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _fetchAddresses,
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No addresses found",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Please add a delivery address to continue",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddAddressScreen()),
                );
                if (result == true) {
                  _fetchAddresses();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Address"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressList() {
    return RefreshIndicator(
      onRefresh: _fetchAddresses,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          final isDefault = address.isDefault == 1;
          final isSelected = selectedAddressId == address.id;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAddressId = address.id;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.greenishWhite
                    : (isDefault
                    ? const Color(0xFFFFF9E6)
                    : (index.isEven
                    ? const Color(0xFFFFF0E0)
                    : const Color(0xFFE8E0F8))),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.greenColor
                      : (isDefault ? AppColors.amberColor : Colors.grey.shade300),
                  width: isSelected ? 2.5 : 1.5,
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: AppColors.greenColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? AppColors.greenColor : Colors.grey,
                            width: 2,
                          ),
                          color: isSelected ? AppColors.greenColor : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, size: 16, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                address.address ?? "No Address",
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isDefault) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.amberColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Default",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (address.streetAddress != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 36, bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: AppColors.greyMedium),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              address.streetAddress!,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (address.city != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 36, bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.location_city, size: 16, color: AppColors.greyMedium),
                          const SizedBox(width: 8),
                          Text(
                            address.city!,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  if (address.apartment != null || address.floor != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 36, bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.home, size: 16, color: AppColors.greyMedium),
                          const SizedBox(width: 8),
                          Text(
                            [
                              if (address.apartment != null) "Apt: ${address.apartment}",
                              if (address.floor != null) "Floor: ${address.floor}",
                            ].join(", "),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  if (address.deliveryInstruction != null &&
                      address.deliveryInstruction!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 36, top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.notes, size: 16, color: AppColors.greyMedium),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Note: ${address.deliveryInstruction}",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontStyle: FontStyle.italic,
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
          );
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add new address button
            OutlinedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddAddressScreen()),
                );
                if (result == true) {
                  _fetchAddresses();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Address"),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  disabledBackgroundColor: Colors.grey[300],
                ),
                onPressed: selectedAddressId != null ? _proceedToCheckout : null,
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  "Proceed to Checkout",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: selectedAddressId != null ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}