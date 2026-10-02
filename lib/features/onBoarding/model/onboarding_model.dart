class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnboardingModel> onboardingData = [
    OnboardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Welcome to Our App',
      description: "Stay in the loop with the biggest breaking stories in a\n stunning visual slider. Just swipe to explore what’s\n trending right now!",
    ),
    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Stay Connected',
      description: '"No more endless scrolling! Tap into your favorite \n topics like Tech, Politics, or Sports and get \n personalized news in seconds"',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Get Started',
      description: "Found something interesting? Tap the bookmark and \n come back to it anytime. Never lose a great read \n again!",
    ),
  ];
}
