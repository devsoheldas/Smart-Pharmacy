import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'address_moduls.dart';


class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
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
    streetSearchController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    houseController = TextEditingController();
    floorController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();
    postCodeController = TextEditingController();
  }

  InputDecoration inputDecoration(String label) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text("Add New Address",style: Theme.of(context).textTheme.headlineMedium ,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Type street name or post code for location",
                style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 6),
              TextFormField(
                controller: streetSearchController,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Bernauer Straße, Berlin, Germany",
                  suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => streetSearchController.clear()),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => v!.isEmpty ? "Enter street or postcode" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                  controller: nameController,
                  decoration: inputDecoration("Name"),
                  validator: (v) => v!.isEmpty ? "Enter name" : null),
              SizedBox(height: 16),
              TextFormField(
                  controller: phoneController,
                  decoration: inputDecoration("Phone"),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v!.isEmpty ? "Enter phone" : null),
              SizedBox(height: 16),
              TextFormField(
                  controller: houseController,
                  decoration: inputDecoration("House Number"),
                  validator: (v) => v!.isEmpty ? "Enter house number" : null),
              SizedBox(height: 16),
              TextFormField(
                  controller: floorController,
                  decoration: inputDecoration("Floor"),
                  validator: (v) => v!.isEmpty ? "Enter floor" : null),
              SizedBox(height: 16),
              TextFormField(
                  controller: streetController,
                  decoration: inputDecoration("Street Name"),
                  validator: (v) => v!.isEmpty ? "Enter street name" : null),
              SizedBox(height: 16),
              TextFormField(
                  controller: cityController,
                  decoration: inputDecoration("City"),
                  validator: (v) => v!.isEmpty ? "Enter city" : null),
              SizedBox(height: 16),
              TextFormField(
                  controller: postCodeController,
                  decoration: inputDecoration("Post Code"),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "Enter post code" : null),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("+ Add New Address",
                    style: Theme.of(context).textTheme.titleMedium,),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
