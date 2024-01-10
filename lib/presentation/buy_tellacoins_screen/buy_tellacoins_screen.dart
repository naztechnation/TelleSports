import 'package:tellesports/utils/navigator/page_navigator.dart';

import '../../widgets/custom_outlined_button.dart';
import '../buy_tellacoins_screen/widgets/communityleader_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import '../withdraw_tellacoin.dart/withdraw_tellacoins_one_screen.dart';

class BuyTellacoinsScreen extends StatelessWidget {
  BuyTellacoinsScreen({Key? key})
      : super(
          key: key,
        );

  final List<Map<String, dynamic>> myList = [
    {
      'amount': 'N2000',
      'title': 'Community leader',
      'color': Color(0xFF1E654A),
      'bg': Color(0xFF84CBB0),
      'body': [
        '150 Tellacoins',
        'Create and manage a community.',
        'Earn rewards and money through your community.'
      ],
      'isCommunity': true,
    },
    {
      'amount': 'N1500',
      'title': 'Regular',
      'color': Color(0xFF1E654A),
      'bg': Color(0xFF84CBB0),
      'body': [
        '100 Tellacoins',
        'Join communities and connect with other users.',
      ],
      'isFlagTrue': false,
    },
    {
      'amount': 'N700',
      'title': 'Starter',
      'color': Color(0xFF1E654A),
      'bg': Color(0xFF84CBB0),
      'body': [
        '50 Tellacoins',
        'Join communities and connect with other users.',
      ],
      'isFlagTrue': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 21.v),
          child: Column(
            children: [
              _buildTelacoinsBalance(context),
              SizedBox(height: 16.v),
              _buildCashTellacoins(context),
              SizedBox(height: 16.v),
              Divider(
                color: appTheme.gray50001,
              ),
              SizedBox(height: 15.v),
              _buildCommunityLeader(context),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Buy Tellacoins",
        margin: EdgeInsets.only(
          top: 50.v,
          bottom: 8.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildStarterPlan(BuildContext context) {
    return CustomElevatedButton(
      height: 23.v,
      width: 106.h,
      text: "Starter plan".toUpperCase(),
      margin: EdgeInsets.only(right: 12.h),
      buttonStyle: CustomButtonStyles.fillTeal,
      buttonTextStyle: CustomTextStyles.labelLargeInter,
      alignment: Alignment.centerRight,
    );
  }

  Widget _buildTelacoinsBalance(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(0),
      color: Color(0xFF1E654A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Container(
        height: 85.v,
        width: 350.h,
        decoration: BoxDecoration(color: Color(0xFF1E654A)),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            CustomImageView(
              color: Color(0xFF144432),
              imagePath: ImageConstant.imgEllipse74,
              height: 41.v,
              width: 317.h,
              alignment: Alignment.bottomRight,
            ),
            CustomImageView(
              color: Color(0xFF144432),
              imagePath: ImageConstant.imgEllipse84,
              height: 40.v,
              width: 288.h,
              alignment: Alignment.topLeft,
            ),
            _buildStarterPlan(context),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tellacoin balance:".toUpperCase(),
                      style: CustomTextStyles.bodySmallWhiteA700,
                    ),
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSettings,
                          height: 26.adaptSize,
                          width: 26.adaptSize,
                          margin: EdgeInsets.only(
                            top: 8.v,
                            bottom: 7.v,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: Text(
                            "200",
                            style: CustomTextStyles.headlineLargeWhiteA700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCashTellacoins(BuildContext context) {
    return CustomOutlinedButton(
        leftIcon: CustomImageView(
          imagePath: ImageConstant.cash,
        ),
        onPressed: () => AppNavigator.pushAndStackPage(context, page: WithdrawTellaCoins()),
        text: "  Cash Tellacoins",
        margin: EdgeInsets.symmetric(horizontal: 20.h));
  }

  Widget _buildCommunityLeader(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 24.v,
            );
          },
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return CommunityleaderItemWidget(
              data: myList[index],
              body: myList[index]['body'],
            );
          },
        ),
      ),
    );
  }
}
