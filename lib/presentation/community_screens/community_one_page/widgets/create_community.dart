import 'package:flutter/material.dart';

import '../../../../utils/navigator/page_navigator.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../create_community_pages/create_a_community_one_screen.dart';

Widget buildBuyTellacoins(BuildContext context) {
    return CustomElevatedButton(
      buttonStyle: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3C91E5),),
      buttonTextStyle: TextStyle(color: Colors.white),
      leftIcon: const Icon(
            Icons.people_alt_sharp,
            color: Colors.white,
          ),
        text: "  Create a community", 
        onPressed: () {
          AppNavigator.pushAndStackPage(context, page: CreateACommunityOneScreen());
        },
        );
  }