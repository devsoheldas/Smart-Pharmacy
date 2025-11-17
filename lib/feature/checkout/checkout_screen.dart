import 'package:flutter/material.dart';
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  bool isSwitch = false;
  String? isRadio ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: (){},
            icon: Icon(Icons.arrow_back_ios),),
        title: Text("Checkout",style: Theme.of(context).textTheme.titleMedium,),
        centerTitle: true,
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Payment",style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Transform.scale(
                        scale: 0.5,
                        child: Switch(value: isSwitch,
                            onChanged: (value){
                              setState(() {
                                isSwitch = value;
                              });
                            }
                        ),
                      ),
                    ),
                    title: Text("Master Card",style: Theme.of(context).textTheme.bodySmall,),
                    trailing: Radio(
                      value: "yes",
                      groupValue: isRadio,
                      onChanged: (value){
                        setState(() {
                          isRadio = value ;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading:  Icon(Icons.paypal_outlined,color: Colors.blueAccent,),
                    title: Text("Pay Pal",style: Theme.of(context).textTheme.bodySmall,),
                    trailing: Radio(
                      value: "no",
                      groupValue: isRadio,
                      onChanged: (value){
                        setState(() {
                          isRadio = value ;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading:  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.more_vert,color: Colors.black,)
                    ),
                    title: Text("Pay Pal",style: Theme.of(context).textTheme.bodySmall,),
                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined)),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.amberAccent.shade100
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(" EcoThrive ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700
                            ),),
                            Transform.scale(
                              scale: 0.5,
                              child: Switch(value: isSwitch,
                                  onChanged: (value){
                                    setState(() {
                                      isSwitch = value;
                                    });
                                  }
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        SizedBox(
                            height: 50,
                            width: 60,
                            child: Image.asset("assets/images/Sim Card.png")),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("1234" ),
                            Text("1234" ),
                            Text("1234" ),
                            Text("1234" ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jonathan Smith", style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                            ),),
                            Text(" 12/29 ", style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                            ),)
                          ],
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
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
                        Text("Total (6 items)",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                        ),),
                        Text("\$27.59 ",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                        ),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)
                        )
                      ),
                      onPressed: (){}, child: Text("Pay")),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
