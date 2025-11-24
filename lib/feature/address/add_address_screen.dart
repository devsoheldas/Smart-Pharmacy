import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/core/services/network/api_service.dart';
import 'package:flutter/material.dart';


class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _addressService = ApiService();

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
    addressController = TextEditingController();
    cityController = TextEditingController();
    streetAddressController = TextEditingController();
    apartmentController = TextEditingController();
    floorController = TextEditingController();
    deliveryInstructionController = TextEditingController();
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

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);


    final addressData = {
      'address': addressController.text,
      'city': cityController.text,
      'street_address': streetAddressController.text,
      'apartment': apartmentController.text,
      'floor': floorController.text,
      'delivery_instruction': deliveryInstructionController.text,

    };

    final response = await _addressService.addAddress(addressData);

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
          "Add New Address",
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
                    "Enter your address details",
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
                      onPressed: isLoading ? null : _saveAddress,
                      child: Text(
                        isLoading ? "Saving..." : "+ Add New Address",
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