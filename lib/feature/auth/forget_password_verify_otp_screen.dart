import 'package:e_pharma/feature/auth/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/constants/app_colors.dart';

class ForgotPasswordVerifyOTPScreen extends StatefulWidget {
  const ForgotPasswordVerifyOTPScreen({super.key, required this.email});

  final String email;

  @override
  State<ForgotPasswordVerifyOTPScreen> createState() =>
      _ForgotPasswordVerifyOTPScreenState();
}

class _ForgotPasswordVerifyOTPScreenState
    extends State<ForgotPasswordVerifyOTPScreen> {
  TextEditingController _otpController = TextEditingController();

  void _onVerifyPressed() {
    if (_otpController.text.length == 6) {
      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OTP Verified Successfully!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(email: ''),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter a valid 6-digit OTP"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26),
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
                        const SizedBox(height: 20),

                        //back
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 0),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.white70,
                                  size: 28,
                                ),
                              ),
                              iconSize: 48,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Icon
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.verified_user_rounded,
                                  color: Color(0xff6C63FF),
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Verify OTP",
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Enter the 6-digit OTP sent to",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.email,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // OTP
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Enter OTP Code",
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                              ),
                              const SizedBox(height: 20),
                              PinCodeTextField(
                                appContext: context,
                                length: 6,
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                                autoDisposeControllers: false,
                                animationType: AnimationType.scale,
                                animationDuration: const Duration(
                                  milliseconds: 300,
                                ),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  borderRadius: BorderRadius.circular(8),
                                  fieldHeight: 60,
                                  fieldWidth: 45,
                                  inactiveFillColor: Colors.grey[50]!,
                                  activeFillColor: Colors.grey[50]!,
                                  selectedFillColor: Colors.grey[50]!,
                                  inactiveColor: Colors.grey[400]!,
                                  activeColor: const Color(0xff6C63FF),
                                  selectedColor: const Color(0xff6C63FF),
                                ),
                                enableActiveFill: true,
                                onChanged: (value) {},
                              ),
                              const SizedBox(height: 30),

                              // Verifi
                              SizedBox(
                                width: double.infinity,
                                height: 58,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xff6C63FF,
                                    ).withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _onVerifyPressed,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff6C63FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 5,
                                      shadowColor: const Color(
                                        0xff6C63FF,
                                      ).withOpacity(0.5),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "VERIFY OTP",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),
                        Spacer(),

                        //Resend
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive the code?",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("OTP resent successfully"),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
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
    _otpController.dispose();
    super.dispose();
  }
}
