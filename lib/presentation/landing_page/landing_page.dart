

import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_bar.dart';
import '../community_tab_container_page/community_tab_page.dart';
import '../convert_betcodesone_tab_container_page/convert_betcodesone_tab_container_page.dart';
import '../predictions_page/predictions_page.dart';
import '../predictions_two_page/predictions_two_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

   int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(


      body: _buildPage(_currentIndex),
      bottomNavigationBar: CustomBottomBar(

        onChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
       ),
    );
  }

    Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return ConvertBetcodesoneTabContainerPage();
      case 1:
        return CommunityTabPage();
      case 2:
        return PredictionsTwoPage();
      case 3:
        return PredictionsPage();
      default:
        return DefaultWidge();
    }
  }
}