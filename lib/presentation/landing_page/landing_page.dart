

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/account_view_model.dart';
import '../../widgets/custom_bottom_bar.dart'; 
import '../community_screens/community_one_page/community_tab_page.dart';
import '../home_page/home_page.dart';
import '../profile/profile_page.dart';
import '../predictions_page/predictions_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

   
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AccountViewModel>(context, listen: true);

    return   Scaffold(


      body: _buildPage(user.currentPage),
      bottomNavigationBar: CustomBottomBar(

        onChanged: (index) {
          setState(() {
            user.updateIndex(index);
          });
        },
       selectedIndex: user.currentPage
       ),
    );
  }

    Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return CommunityTabPage();
      case 2:
        return PredictionsPage();
      case 3:
        return ProfilePage();
      default:
        return DefaultWidge();
    }
  }
}