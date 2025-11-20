import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/feature/auth/ui/singup_screen.dart';
import 'package:e_pharma/feature/product/ui/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_asset_paths.dart';
import '../widgets/social_login_button.dart';
import 'forget_password_verify_email_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient:
          AppColors.appBGGradientColor
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Center(child: Lottie.asset(
                          'assets/lottie/login.json',
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller
                              ..duration = composition.duration
                              ..forward();
                          },
                          repeat: false,
                          height: 250,
                          width: 250,
                        ),),
                        const Spacer(),
                        // Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(26, 24, 26, 40),
                          decoration: const BoxDecoration(
                            color: Color(0xffF7F7FB),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(22),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      // Email
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF1F1F7),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: _emailController,
                                          keyboardType:
                                          TextInputType.emailAddress,
                                          validator: (String? value) {
                                            String inputText = value ?? "";
                                            if (EmailValidator.validate(
                                              inputText,
                                            ) ==
                                                false) {
                                              return "Enter your valid email";
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              color: Color(0xff6A63FF),
                                            ),
                                            hintText: "Email Address",
                                            border: InputBorder.none,
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      // Password
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF1F1F7),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          obscureText: _obscureText,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your password";
                                            }
                                            if (value.length < 6) {
                                              return "Password must be at least 6 characters";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.lock_outline,
                                              color: Color(0xff6A63FF),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscureText
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: const Color(0xff6A63FF),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                            ),
                                            hintText: "Password",
                                            border: InputBorder.none,
                                            contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPasswordVerifyEmailScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Color(0xff6A63FF),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Login
                                SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // if (_formKey.currentState!.validate()) {
                                      //   ScaffoldMessenger.of(
                                      //     context,
                                      //   ).showSnackBar(
                                      //     const SnackBar(
                                      //       content: Text("Logging in..."),
                                      //     ),
                                      //   );
                                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));
                                      //
                                      // }

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));

                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9775FA),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 6,
                                    ),
                                    child: const Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                // Divider OR
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(color: Colors.grey[400]),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        "Or",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(color: Colors.grey[400]),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SocialLoginButton(
                                      onTap: () {},
                                      image: AssetPaths.google,
                                    ),
                                    const SizedBox(width: 18),
                                    SocialLoginButton(
                                      onTap: () {},
                                      image: AssetPaths.facebook,
                                    ),
                                    const SizedBox(width: 18),
                                    SocialLoginButton(
                                      onTap: () {},
                                      image: AssetPaths.apple,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don't have an account? "),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: Color(0xff6C63FF),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}