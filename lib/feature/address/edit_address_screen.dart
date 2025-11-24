import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/models/address_response_model.dart';
import 'package:e_pharma/core/services/address_service.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  final AddressData address;

  const EditAddressScreen({super.key, required this.address});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final AddressService _addressService = AddressService();

  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController streetAddressController;
  late TextEditingController apartmentController;
  late TextEditingController floorController;
  late TextEditingController deliveryInstructionController;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.address.address ?? '');
    cityController = TextEditingController(text: widget.address.city ?? '');
    streetAddressController = TextEditingController(text: widget.address.streetAddress ?? '');
    apartmentController = TextEditingController(text: widget.address.apartment ?? '');
    floorController = TextEditingController(text: widget.address.floor ?? '');
    deliveryInstructionController = TextEditingController(text: widget.address.deliveryInstruction ?? '');
  }

  @override
  void dispose() {
    addressController.dispose();
    cityController.dispose();
    streetAddressController.dispose();
    apartmentController.dispose();
    floorController.dispose();
    deliveryInstructionController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String label, {bool required = true}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.greenColor, width: 2),
      ),
    );
  }

  Future<void> _updateAddress() async {
    if (!_formKey.currentState!.validate()) return;

    if (widget.address.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address ID not found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);


    final addressData = {
      'address': addressController.text,
      'city': cityController.text,
      'street_address': streetAddressController.text,
      'apartment': apartmentController.text,
      'floor': floorController.text,
      'delivery_instruction': deliveryInstructionController.text,
    };

    final response = await _addressService.updateAddress(
      widget.address.id!,
      addressData,
    );

    setState(() => isLoading = false);

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          "Edit Address",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Update your address details",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: addressController,
                    decoration: inputDecoration("Address"),
                    maxLines: 2,
                    validator: (v) => v!.isEmpty ? "Enter address" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: cityController,
                    decoration: inputDecoration("City"),
                    validator: (v) => v!.isEmpty ? "Enter city" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: streetAddressController,
                    decoration: inputDecoration("Street Address"),
                    validator: (v) => v!.isEmpty ? "Enter street address" : null,
                  ),
                  const SizedBox(height: 16),


                  TextFormField(
                    controller: apartmentController,
                    decoration: inputDecoration("Apartment / House Number"),
                    validator: (v) => v!.isEmpty ? "Enter apartment/house number" : null,
                  ),
                  const SizedBox(height: 16),


                  TextFormField(
                    controller: floorController,
                    decoration: inputDecoration("Floor", required: false),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: deliveryInstructionController,
                    decoration: inputDecoration("Delivery Instruction", required: false),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading ? null : _updateAddress,
                      child: Text(
                        isLoading ? "Updating..." : "Update Address",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}