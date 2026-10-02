import 'package:flutter/material.dart';
import 'package:newst/core/datasource/local_source/preference_manager.dart';
import 'package:newst/features/auth/screen/login_screen.dart';
import 'package:newst/features/onBoarding/controller/onboarding_controller.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  _onFinish(BuildContext context) async {
    // Save a flag in shared preferences to indicate that onboarding is completed
    final preferenceManager = PreferenceManager();
    // await preferenceManager.init();
    await preferenceManager.setBoolean('onboarding_completed', true);

    // Navigate to the next screen (e.g., login screen)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OnboardingController(),
      builder: (context, child) {
        final controller = context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFf5f5f5),
            actions: [
              Consumer<OnboardingController>(
                builder:
                    (
                      BuildContext context,
                      OnboardingController value,
                      Widget? child,
                    ) {
                      return value.isLastPage
                          ? SizedBox()
                          : TextButton(
                              onPressed: () {
                                _onFinish(context);
                              },
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 201, 2, 2),
                                ),
                              ),
                            );
                    },
              ),
            ],
          ),
        );
      },
    );
  }
}
