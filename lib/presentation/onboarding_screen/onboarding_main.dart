  import 'package:flutter/material.dart';

import 'onboarding_three_screen.dart';
import 'onboarding_two_screen.dart';
import 'onboarding_one_screen.dart';

 

class OnboardingMain extends StatefulWidget {
  @override
  _OnboardingMainState createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          OnboardingOneScreen(),
          OnboardingTwoScreen(),
          OnboardingThreeScreen(),
          
        ],
      ),
    );
  }

 
}
