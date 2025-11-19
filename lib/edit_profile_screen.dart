import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    cityCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        'name': nameCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'city': cityCtrl.text.trim(),
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        elevation: 1,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey.shade300),
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        "https://scontent.fdac139-1.fna.fbcdn.net/v/t39."
                            "30808-6/574031408_799180149766210_42234144146"
                            "72799318_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_"
                            "nc_ohc=30W3y47GeqAQ7kNvwHJR8Ad&_nc_oc=AdkK2eLdN4Q6RTWVu"
                            "v4zJBqo7vVcnXwIYHrwJv33uR_5lg527-pdtaCYrlbk2Ty_S2g&_nc_zt"
                            "=23&_nc_ht=scontent.fdac139-1.fna&_nc_gid=bXHm131qCH2Oqug"
                            "5RGawvg&oh=00_AfitodJmfiQFFYGZ20fW5puPLz3aTMLBsE4EyOEXv-D_"
                            "ng&oe=691F7611",
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),


                TextFormField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (v) =>
                  v!.trim().isEmpty ? "Name is required" : null,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (v) {
                    if (v!.trim().isEmpty) return "Email is required";
                    final emailReg = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailReg.hasMatch(v.trim())) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),

                TextFormField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.phone_android),
                  ),
                  validator: (v) =>
                  v!.trim().length < 10 ? "Enter valid number" : null,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: cityCtrl,
                  decoration: InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.location_city),
                  ),
                  validator: (v) =>
                  v!.trim().isEmpty ? "City is required" : null,
                ),
                SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Save", style: TextStyle(fontSize: 16),),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
