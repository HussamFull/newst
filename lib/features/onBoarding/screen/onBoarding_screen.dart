import 'package:flutter/material.dart';
import 'package:newst/core/datasource/local_source/preference_manager.dart';
import 'package:newst/features/auth/screen/login_screen.dart';
import 'package:newst/features/onBoarding/controller/onboarding_controller.dart';
import 'package:newst/features/onBoarding/model/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  Future<void> _onFinish(BuildContext context) async {
    // Create PreferenceManager
    final preferenceManager = PreferenceManager();

    // Save onboarding completed flag
    await preferenceManager.setBoolean(
      'onboarding_completed',
      true,
    );

    // Navigate to Login Screen
    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingController(),
      child: Builder(
        builder: (context) {
          final controller = context.read<OnboardingController>();

          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),

            // =========================
            // APP BAR
            // =========================
            appBar: AppBar(
              backgroundColor: const Color(0xFFF5F5F5),
              elevation: 0,

              actions: [
                Consumer<OnboardingController>(
                  builder: (
                    context,
                    value,
                    child,
                  ) {
                    return value.isLastPage
                        ? const SizedBox.shrink()
                        : TextButton(
                            onPressed: () {
                              _onFinish(context);
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Color(0xFFC50202),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),

            // =========================
            // BODY
            // =========================
            body: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Column(
                children: [
                  // =========================
                  // PAGE VIEW
                  // =========================
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,

                      onPageChanged: (int index) {
                        context
                            .read<OnboardingController>()
                            .onPageChanged(index);
                      },

                      // IMPORTANT:
                      // Make sure your model uses the same name.
                      itemCount: OnboardingModel.onboardingList.length,

                      itemBuilder: (
                        context,
                        index,
                      ) {
                        final model =
                            OnboardingModel.onboardingList[index];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // =========================
                            // IMAGE
                            // =========================
                            Image.asset(
                              model.image,
                              height: 240,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(height: 24),

                            // =========================
                            // TITLE
                            // =========================
                            Text(
                              model.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4E4B66),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // =========================
                            // DESCRIPTION
                            // =========================
                            Text(
                              model.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF6E7191),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // PAGE INDICATOR
                  // =========================
                  Consumer<OnboardingController>(
                    builder: (
                      context,
                      value,
                      child,
                    ) {
                      return SmoothPageIndicator(
                        controller: value.pageController,

                        count: OnboardingModel.onboardingList.length,

                        effect: const WormEffect(
                          activeDotColor: Color(0xFFC53030),
                          dotColor: Color(0xFFD9D9D9),
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 8,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // =========================
                  // NEXT / GET STARTED BUTTON
                  // =========================
                  Consumer<OnboardingController>(
                    builder: (
                      context,
                      value,
                      child,
                    ) {
                      return SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            if (value.isLastPage) {
                              _onFinish(context);
                            } else {
                              controller.pageController.nextPage(
                                duration: const Duration(
                                  milliseconds: 300,
                                ),
                                curve: Curves.easeInOut,
                              );
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFC53030),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),

                          child: Text(
                            value.isLastPage
                                ? 'Get Started'
                                : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}