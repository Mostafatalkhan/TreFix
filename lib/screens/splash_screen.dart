import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:treflix/screens/onBoarding/onboarding_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      nextScreen: const OnboardinView(),
      splash: 'assets/sp.gif',
      splashIconSize: size.width,
      backgroundColor: Colors.black,
      splashTransition: SplashTransition.fadeTransition,
      duration: 1500,
      animationDuration: Duration(seconds: 2),
      pageTransitionType: PageTransitionType.rightToLeft,
    );
  }
}
