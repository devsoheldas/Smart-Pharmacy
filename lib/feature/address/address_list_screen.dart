import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/models/address_response_model.dart';
import 'package:e_pharma/core/services/address_service.dart';
import 'package:flutter/material.dart';
import 'Edit_address_screen.dart';
import 'add_address_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final AddressService _addressService = AddressService();
  List<AddressData> addresses = [];
  bool isLoading = true;
  String? errorMessage;

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
      } else {
        errorMessage = response.message;
      }
    });
  }

  Future<void> _deleteAddress(int addressId, int index) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final response = await _addressService.deleteAddress(addressId);

    Navigator.pop(context);

    if (response.success) {
      setState(() {
        addresses.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _setDefaultAddress(int addressId) async {
    final response = await _addressService.setDefaultAddress(addressId);

    if (response.success) {
      _fetchAddresses();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message), backgroundColor: Colors.red),
      );
    }
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
          "My Address",
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
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage!,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchAddresses,
              child: const Text("Retry"),
            ),
          ],
        ),
      )
          : addresses.isEmpty
          ? Center(
        child: Text(
          "No addresses added yet.",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      )
          : RefreshIndicator(
        onRefresh: _fetchAddresses,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final address = addresses[index];
            final isDefault = address.isDefault == 1;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDefault
                    ? const Color(0xFFE8F5E9)
                    : (index.isEven
                    ? const Color(0xFFFFF0E0)
                    : const Color(0xFFE8E0F8)),
                borderRadius: BorderRadius.circular(20),
                border: isDefault
                    ? Border.all(color: Colors.green, width: 2)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    address.address ?? "No Address",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isDefault) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                      BorderRadius.circular(8),
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
                            const SizedBox(height: 4),
                            if (address.city != null)
                              Text(
                                address.city!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall,
                              ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          if (!isDefault)
                            IconButton(
                              icon: const Icon(Icons.check_circle_outline,
                                  color: Colors.grey),
                              onPressed: () {
                                if (address.id != null) {
                                  _setDefaultAddress(address.id!);
                                }
                              },
                              tooltip: "Set as Default",
                            ),
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.blue),
                            onPressed: () async {
                              final updated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditAddressScreen(address: address),
                                ),
                              );
                              if (updated == true) {
                                _fetchAddresses();
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: AppColors.primaryColor),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Delete Address"),
                                  content: const Text(
                                      "Are you sure you want to delete this address?"),
                                  actions: [
                                    TextButton(
                                      child: const Text("No"),
                                      onPressed: () =>
                                          Navigator.pop(context),
                                    ),
                                    TextButton(
                                      child: Text("Yes",
                                          style: TextStyle(
                                              color: AppColors
                                                  .primaryColor)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        if (address.id != null) {
                                          _deleteAddress(
                                              address.id!, index);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (address.streetAddress != null)
                    Text(
                      "Street: ${address.streetAddress}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  if (address.apartment != null)
                    Text(
                      "Apartment: ${address.apartment}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  if (address.floor != null)
                    Text(
                      "Floor: ${address.floor}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  if (address.deliveryInstruction != null &&
                      address.deliveryInstruction!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Note: ${address.deliveryInstruction}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              "+ Add New Address",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddAddressScreen()),
              );
              if (result == true) {
                _fetchAddresses();
              }
            },
          ),
        ),
      ),
    );
  }
}