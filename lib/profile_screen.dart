import 'package:flutter/material.dart';

import 'checkout_page.dart';
import 'edit_profile_screen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userLocation = "Mirpur-10,Dhaka";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello",style: TextStyle(height: 3),),),
      body: Container(
        child: Column(
          children: [


            Container(
              padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network('https://scontent.fdac139-1.fna.fbcdn.net/v/'
                          't39.30808-6/574031408_799180149766210_4223414414672799318_n.'
                          'jpg?stp=dst-jpg_s720x720_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_ohc='
                          'IL3X6xv7vgwQ7kNvwGVPHUW&_nc_oc=AdnHWxsRDFE3mnLUGqwevysz547X3eZmh5CP8Y8UWw'
                          '3Qw08yP5Z50cPr7baKny38ztQ&_nc_zt=23&_nc_ht=scontent.fdac139-1.fna&_nc_gid='
                          '1VrRQSjGi-8fFsriHyP7tQ&oh=00_Afh1qbsolVLCWCEy8beMZ3n-e49LKNpQd1B1vf48Bgeq-A&oe=691E2491',
                        width: 80, height: 80, fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sayedur Rahman Sohan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black,),),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 18, color: Colors.grey[700]),
                                SizedBox(width: 4), Text(userLocation, style: TextStyle(fontSize: 14, color: Colors.grey[700]),),
                              ],),
                            SizedBox(width: 25,),
                            ElevatedButton(onPressed: () {
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
                            },child: Text('Edit'),
                            ),
                          ],),
                      ],
                    ),

                  ],
                  ),
                ],
              ),
            ),//=====1
            SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Statistic', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),),
                        SizedBox(width: 16),
                        Text('More Detailse', style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold, color: Colors.grey[700]),),
                        SizedBox(width: 2),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CheckoutPage()),
                            );
                          },
                          child: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Shipping', style: TextStyle(fontSize: 16,color: Colors.grey)),
                            Text('Rating', style: TextStyle(fontSize: 16,color: Colors.grey)),
                          ],),

                        SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('125', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
                            Text('5', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
                          ],),

                        SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Point', style: TextStyle(fontSize: 16,color: Colors.grey)),
                            Text('Review', style: TextStyle(fontSize: 16,color: Colors.grey)),
                          ],),

                        SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('1500', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
                            Text('25', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
                          ],),

                      ],),

                  ],),
              ),
            ),//=====2
            SizedBox(height: 8,),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_box_outlined),
                      SizedBox(width: 5,),
                      Text('Privacy & Security'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),SizedBox(height: 6,),
                  Row(
                    children: [
                      Icon(Icons.add_card),
                      SizedBox(width: 5),
                      Text('Notification Preparence'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),SizedBox(height: 6,),
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet_outlined),
                      SizedBox(width: 5),
                      Text('Payment Method'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),SizedBox(height: 6,),
                  Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(width: 5,),
                      Text('Language'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ],
              ),
            ),//=====3
            SizedBox(height: 8,),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.mail_sharp),
                      SizedBox(width: 5,),
                      Text("FAQ"),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),SizedBox(height: 6,),
                  Row(
                    children: [
                      Icon(Icons.help_center),
                      SizedBox(width: 5,),
                      Text("Help Chanter"),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),SizedBox(height: 6,),
                  Row(
                    children: [
                      Icon(Icons.privacy_tip),
                      SizedBox(width: 5,),
                      Text("Privacy Policy"),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),SizedBox(height: 6,),
                  ElevatedButton(
                      onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>EditProfileScreen()));},
                      child: Text("Next Page")
                  ),
                ],
              ),
            )//======4


          ],
        ),
      ),
    );
  }
}
