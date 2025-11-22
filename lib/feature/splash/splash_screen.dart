import 'package:flutter/material.dart';
import 'package:e_pharma/core/services/shared_preference_service.dart';
import '../../core/services/navigation_service.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              "assets/icons/logo.png",
              width: 120,
              height: 120,
            ),

            const SizedBox(height: 20),


            const Text(
              "E-Pharma",
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff9775FA),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 5),


            const Text(
              "Your trusted medicine partner",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 40),


            const CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff9775FA)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasToken = await SharedPrefService.hasToken();

    if (hasToken) {
      NavigationService.pushReplacementNamed(AppRoutes.homeScreen);
    } else {
      NavigationService.pushReplacementNamed(AppRoutes.loginScreen);
    }
  }
}
