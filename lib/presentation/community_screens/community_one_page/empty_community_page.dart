import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../widgets/create_community.dart';

// ignore_for_file: must_be_immutable
class EmptyCommunityPage extends StatefulWidget {
  const EmptyCommunityPage({Key? key})
      : super(
          key: key,
        );

  @override
  CommunityTwoPageState createState() => CommunityTwoPageState();
}

class CommunityTwoPageState extends State<EmptyCommunityPage>
    with AutomaticKeepAliveClientMixin<EmptyCommunityPage> {
  TextEditingController searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return   Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        children: [
          
          
          
          SizedBox(height: 106.v),
          CustomImageView(
            imagePath: ImageConstant.imgCommunicationBusiness,
            height: 198.v,
            width: 158.h,
          ),
          SizedBox(height: 41.v),
          Text(
            "Join a community and stay up to date on all things sports!",
            style:  TextStyle(fontSize: 15),
          ),
          SizedBox(height: 20.v),
          

          // buildBuyTellacoins(context),
          // SizedBox(height: 10.v),
          // CustomOutlinedButton(
          //   text: "Explore Communities",
          // ),
        ],
      ),
    );
  }

  
}
