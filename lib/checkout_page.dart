import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int quantity = 1;
  final TextEditingController promoController = TextEditingController();
  String userLocation="Sayedur Rahman\nBuilding No: 45, Ashram Road,\nAhmedabad, Gujarat, 380009\nPhone Number: +01 (555) 555-0100";

  @override
  Widget build(BuildContext context) {
    double itemPrice = 12000;
    double tax = 2160;
    double deliveryCharge = 150;
    double total = itemPrice * quantity + tax + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Image.network('https://scontent.fdac139-1.fna.fbcdn.net/v/'
                      't39.30808-6/574031408_799180149766210_4223414414672799318_n.'
                      'jpg?stp=dst-jpg_s720x720_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_ohc='
                      'IL3X6xv7vgwQ7kNvwGVPHUW&_nc_oc=AdnHWxsRDFE3mnLUGqwevysz547X3eZmh5CP8Y8UWw'
                      '3Qw08yP5Z50cPr7baKny38ztQ&_nc_zt=23&_nc_ht=scontent.fdac139-1.fna&_nc_gid='
                      '1VrRQSjGi-8fFsriHyP7tQ&oh=00_Afh1qbsolVLCWCEy8beMZ3n-e49LKNpQd1B1vf48Bgeq-A&oe=691E2491',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Red lehenga',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Wedding'),
                        SizedBox(height: 4),
                        Text('₹12,000',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() => quantity++);
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Shipping Address Ekhan Theke Suru
              Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              Container(                         //====Address
                padding:EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(userLocation),
                    ),

                    TextButton(onPressed: () {
                      showDialog(context: context,
                        builder: (BuildContext context)
                        {TextEditingController locationController = TextEditingController(text: userLocation);

                        return AlertDialog(
                          title: Text("Edit Location"),
                          content: TextField(
                            controller: locationController,
                            decoration: InputDecoration(
                              hintText: "Enter new location",),),
                          actions: [
                            TextButton(onPressed: () {Navigator.pop(context);}, child: Text("Cancel"),),
                            ElevatedButton(onPressed: () {userLocation = locationController.text;Navigator.pop(context);},
                              child: Text("Save"),),
                          ],
                        );
                        },
                      );
                    },child: Text('Chang'),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 12),


              Text('Add Promo Code', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: promoController,
                      decoration: InputDecoration(
                        hintText: 'Add Promo Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    child:Text('Apply',
                        style: TextStyle(color: Colors.pink)),
                  ),
                ],
              ),

              const SizedBox(height: 12),


              Text('Order Info', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _orderRow('Sub Total', '₹${itemPrice * quantity}'),
                    _orderRow('Tax', '₹$tax'),
                    _orderRow('Delivery Charge', '₹$deliveryCharge'),
                    const Divider(),
                    _orderRow('Total', '₹${total.toStringAsFixed(0)}',
                        isTotal: true),
                  ],
                ),
              ),

              SizedBox(height: 20),


              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Pay ₹${total.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              )),
          Text(value,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              )),
        ],
      ),
    );
  }
}
