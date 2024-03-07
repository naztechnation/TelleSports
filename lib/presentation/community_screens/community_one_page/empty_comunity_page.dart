import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import 'widgets/create_community.dart';

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
          SizedBox(height: 12.v),
          CustomTextFormField(
            controller: searchController,
            hintText: "Search for communities or users",
            hintStyle: CustomTextStyles.titleSmallGray400,
            textInputAction: TextInputAction.done,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 5.v, 9.h, 5.v),
              child: CustomImageView(
                imagePath: ImageConstant.imgSearchGray400,
                height: 24.adaptSize,
                width: 24.adaptSize,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 34.v,
            ),
            contentPadding: EdgeInsets.only(
              top: 7.v,
              right: 30.h,
              bottom: 7.v,
            ),
            borderDecoration: TextFormFieldStyleHelper.fillGray,
            filled: true,
            fillColor: appTheme.gray100,
          ),
          SizedBox(height: 20.v),
    
          Divider(),
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
