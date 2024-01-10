import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_title.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

class SelectBankAccount extends StatelessWidget {
  SelectBankAccount({Key? key})
      : super(
          key: key,
        );

  TextEditingController videocameraController = TextEditingController();

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
                controller: videocameraController,
                hintText: "You are not eligible to  withdraw tellacoins",
                textInputAction: TextInputAction.done,
                prefix: Container(
                  margin: EdgeInsets.fromLTRB(10.h, 8.v, 8.h, 8.v),
                  child: CustomImageView(
                 //   imagePath: ImageConstant.imgVideocamera,
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
                //borderDecoration: TextFormFieldStyleHelper.fillLime,
                filled: true,
                fillColor: appTheme.lime50,
              ),
              SizedBox(height: 16.v),
              _buildTelacoinsBalance(context),
              SizedBox(height: 17.v),
              Text(
                "Withdrawal Eligibility ",
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 16.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15.v),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Row(
                  children: [
                    CustomImageView(
                     // imagePath: ImageConstant.imgCheck,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(bottom: 2.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "Buy a community leader plan",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontSize: 14.fSize,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.v),
              _buildFrame(context),
              SizedBox(height: 7.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 12.h,
                  right: 30.h,
                ),
                child: Row(
                  children: [
                    CustomImageView(
                    //  imagePath: ImageConstant.imgCheck,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.symmetric(vertical: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "Have a minimum balance of 1000 Tellacoins",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontSize: 14.fSize,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
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
              imagePath: ImageConstant.imgEllipse741x317,
              height: 41.v,
              width: 317.h,
              alignment: Alignment.bottomRight,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgEllipse840x288,
              height: 40.v,
              width: 288.h,
              alignment: Alignment.topLeft,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12.h,
                  right: 228.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Padding(
                      padding: EdgeInsets.only(right: 14.h),
                      child: Row(
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
                              style: TextStyle(
                                color:
                                    theme.colorScheme.onPrimary.withOpacity(1),
                                fontSize: 32.fSize,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
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

   
  Widget _buildFrame(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.h,
          right: 14.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              // imagePath: ImageConstant.imgCheck,
              height: 16.adaptSize,
              width: 16.adaptSize,
              margin: EdgeInsets.only(bottom: 20.v),
            ),
            Expanded(
              child: Container(
                width: 303.h,
                margin: EdgeInsets.only(left: 4.h),
                child: Text(
                  "Create and manage a community with at least 100 members",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontSize: 14.fSize,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
