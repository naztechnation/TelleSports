import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';


class WithdrawTellaCoins extends StatelessWidget {
  WithdrawTellaCoins({Key? key})
      : super(
          key: key,
        );

  TextEditingController eligibleMessageController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: eligibleMessageController,
                hintText: "You are eligible to  withdraw tellacoins",
                prefix: Container(
                  margin: EdgeInsets.fromLTRB(10.h, 8.v, 8.h, 8.v),
                  child: CustomImageView(
                  //  imagePath: ImageConstant.imgVideocameraGreen700,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                  ),
                ),
                prefixConstraints: BoxConstraints(
                  maxHeight: 40.v,
                ),
                contentPadding: EdgeInsets.only(
                  top: 12.v,
                  right: 30.h,
                  bottom: 12.v,
                ),
                borderDecoration: TextFormFieldStyleHelper.fillBlueGray,
                filled: true,
                fillColor: appTheme.blueGray50,
              ),
              SizedBox(height: 16.v),
              _buildTelacoinsBalance(context),
              SizedBox(height: 15.v),
              _buildTextField(context),
              SizedBox(height: 23.v),
              Text(
                "1 Tellacoin = N20",
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 14.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 23.v),
              CustomElevatedButton(
                text: "Continue",
              ),
              SizedBox(height: 5.v),
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
        onTap: (){
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Withdraw Tellacoins",
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
      
    );
  }

   
  Widget _buildTelacoinsBalance(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: theme.colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Container(
        height: 72.v,
        width: 350.h,
        // decoration: AppDecoration.fillSecondaryContainer.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder8,
        // ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgEllipse71,
              height: 41.v,
              width: 317.h,
              alignment: Alignment.bottomRight,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgEllipse81,
              height: 40.v,
              width: 288.h,
              alignment: Alignment.topLeft,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12.h,
                  right: 225.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tellacoin balance:".toUpperCase(),
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary.withOpacity(1),
                        fontSize: 11.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            "1000",
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary.withOpacity(1),
                              fontSize: 32.fSize,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomElevatedButton(
              height: 23.v,
              width: 143.h,
              text: "COMMUNITY LEADER".toUpperCase(),
              margin: EdgeInsets.only(right: 12.h),
              buttonStyle: CustomButtonStyles.fillTeal,
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }

   
  Widget _buildTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter amount",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3.v),
        CustomTextFormField(
          controller: amountController,
          hintText: "Minimum 500",
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
