import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/netflix.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
          repeat: false,
        ),
      ),
    );
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final hasToken = await SharedPrefService.hasToken();

    if (hasToken) {
      NavigationService.pushReplacementNamed(AppRoutes.homeScreen);
    } else {
      NavigationService.pushReplacementNamed(AppRoutes.loginScreen);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
