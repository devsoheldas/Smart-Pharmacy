import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'address_moduls.dart';


class EditAddressScreen extends StatefulWidget {
  final Address address;

  const EditAddressScreen({super.key, required this.address});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController streetSearchController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController houseController;
  late TextEditingController floorController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController postCodeController;

  @override
  void initState() {
    super.initState();
    streetSearchController =
        TextEditingController(text: widget.address.streetSearch);
    nameController = TextEditingController(text: widget.address.name);
    phoneController = TextEditingController(text: widget.address.phone);
    houseController = TextEditingController(text: widget.address.houseNumber);
    floorController = TextEditingController(text: widget.address.floor);
    streetController = TextEditingController(text: widget.address.streetName);
    cityController = TextEditingController(text: widget.address.city);
    postCodeController = TextEditingController(text: widget.address.postCode);
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Address",
          style: Theme.of(context).textTheme.headlineMedium ,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: streetSearchController,
                decoration: inputDecoration("Street / Postcode"),
                validator: (v) => v!.isEmpty ? "Enter street or postcode" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: inputDecoration("Name"),
                validator: (v) => v!.isEmpty ? "Enter name" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: inputDecoration("Phone"),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? "Enter phone" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: houseController,
                decoration: inputDecoration("House Number"),
                validator: (v) => v!.isEmpty ? "Enter house number" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: floorController,
                decoration: inputDecoration("Floor"),
                validator: (v) => v!.isEmpty ? "Enter floor" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: streetController,
                decoration: inputDecoration("Street Name"),
                validator: (v) => v!.isEmpty ? "Enter street name" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: cityController,
                decoration: inputDecoration("City"),
                validator: (v) => v!.isEmpty ? "Enter city" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: postCodeController,
                decoration: inputDecoration("Post Code"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Enter post code" : null,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(
                        context,
                        Address(
                          streetSearch: streetSearchController.text,
                          name: nameController.text,
                          phone: phoneController.text,
                          houseNumber: houseController.text,
                          floor: floorController.text,
                          streetName: streetController.text,
                          city: cityController.text,
                          postCode: postCodeController.text,
                        ),
                      );
                    }
                  },
                  child: Text("Update Address", style: Theme.of(context).textTheme.titleMedium,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
