import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'Edit_address_screen.dart';
import 'add_address_screen.dart';
import 'address_moduls.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List<Address> addresses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){},
            icon: Icon(Icons.arrow_back)),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text("My Address",style: Theme.of(context).textTheme.headlineMedium ,),
        centerTitle: true,
      ),
      body: addresses.isEmpty
          ? Center(
        child: Text(
          "No addresses added yet.",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: index.isEven
                  ? Color(0xFFFFF0E0)
                  : Color(0xFFE8E0F8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name + Phone
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 4),
                        Text("${address.phone}",
                          style: Theme.of(context).textTheme.titleSmall,),
                      ],
                    ),
                    // Edit & Delete buttons
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue,),
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditAddressScreen(address: address),
                              ),
                            );
                            if (updated != null) {
                              setState(() {
                                addresses[index] = updated;
                              });
                            }
                          },
                        ),

                        IconButton(
                          icon:
                          Icon(Icons.delete, color: AppColors.primaryColor),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Delete Address"),
                                content: Text(
                                    "Are you sure you want to delete this address?"),
                                actions: [
                                  TextButton(
                                    child: Text("No"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: Text("Yes",
                                        style: TextStyle(
                                            color: AppColors.primaryColor)),
                                    onPressed: () {
                                      setState(() {
                                        addresses.removeAt(index);
                                      });
                                      Navigator.pop(context);
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
                SizedBox(height: 8),
                Text("${address.houseNumber}, ${address.streetName}",
                  style: Theme.of(context).textTheme.titleSmall,),
                Text("${address.city}, ${address.postCode}",
                  style: Theme.of(context).textTheme.titleSmall,),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            child: Text("+ Add New Address",
              style: Theme.of(context).textTheme.titleMedium,),

            onPressed: () async {
              final newAddress = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddAddressScreen()),
              );
              if (newAddress != null) {
                setState(() => addresses.add(newAddress));
              }
            },
          ),

        ),
      ),
    );
  }
}
