import 'package:flutter/material.dart';
import 'package:newst/core/datasource/local_source/preference_manager.dart';
import 'package:newst/features/auth/screen/login_screen.dart';
import 'package:newst/features/onBoarding/screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Start navigation after splash
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    // Wait for 3 seconds
    await Future.delayed(
      const Duration(seconds: 3),
    );

    // Get PreferenceManager
    final preferenceManager = PreferenceManager();

    // Check if onboarding was completed
    final onboardingCompleted =
      //  preferenceManager.getBoolean(
     // 'onboarding_completed',
   // ) ??
            false;

    // Make sure widget is still mounted
    if (!mounted) return;

    // Navigate based on onboarding status
    if (onboardingCompleted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}