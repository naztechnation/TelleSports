import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

import '../../utils/navigator/page_navigator.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'transfer_coin.dart';


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
              CustomElevatedButton(
                buttonStyle: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEBF6F2)),
                 decoration: BoxDecoration(color: Color(0xFFEBF6F2), borderRadius: BorderRadius.circular(20)),
                text: "You are eligible to  withdraw tellacoins",
                buttonTextStyle: TextStyle(color: Color(0xFF288763)),
                leftIcon: Container(
                  margin: EdgeInsets.fromLTRB(10.h, 8.v, 8.h, 8.v),
                  child: CustomImageView(
                    color: Color(0xFF288763),
                   imagePath: ImageConstant.imgVideocameraGreen700,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                  ),
                ),
                 
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
              SizedBox(height: 15.v),

              _buildEligibilityCont(),
              SizedBox(height: 23.v),
              CustomElevatedButton(
                text: "Continue",
                onPressed: () => onTapContinueBtn(context),
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
      title: AppbarSubtitle(
        text: "Withdraw Tellacoins",
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
      
    );
  }

   Widget _buildEligibilityCont(){
    return Column(children: [

      SizedBox(height: 17.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Withdrawal Eligibility ",
                  style: TextStyle(
                    color: appTheme.gray900,
                    fontSize: 16.fSize,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
      SizedBox(height: 17.v),

       Row(
         children: [
           CustomImageView(
             imagePath: ImageConstant.imgIcRoundCheck,
             height: 17.adaptSize,
             width: 17.adaptSize,
             margin: EdgeInsets.only(bottom: 1.v),
           ),
           Expanded(
             flex: 8,
             child: Padding(
               padding: EdgeInsets.only(left: 4.h),
               child: Text(
                 'Buy a community leader plan',
                 style: CustomTextStyles.titleSmallBluegray900,
               ),
             ),
           ),
         ],
       ),
            const SizedBox(height: 8,),

            
          

            Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIcRoundCheck,
                  height: 17.adaptSize,
                  width: 17.adaptSize,
                  margin: EdgeInsets.only(bottom: 1.v),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      'Create and manage a community with at least 100 members',
                      style: CustomTextStyles.titleSmallBluegray900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIcRoundCheck,
                  height: 17.adaptSize,
                  width: 17.adaptSize,
                  margin: EdgeInsets.only(bottom: 1.v),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      'Have a minimum balance of 1000 Tellacoins',
                      style: CustomTextStyles.titleSmallBluegray900,
                    ),
                  ),
                ),
              ],
            ),
    ],);
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

  onTapContinueBtn(BuildContext context) {
    AppNavigator.pushAndStackPage(context, page: TransferCoin());
  }

   Widget _buildStarterPlan(BuildContext context) {
    return CustomElevatedButton(
      height: 23.v,
      width: 150.h,
      text: "COMMUNITY LEADER".toUpperCase(),
      margin: EdgeInsets.only(right: 12.h),
      buttonStyle: CustomButtonStyles.fillTeal,
      buttonTextStyle: CustomTextStyles.labelLargeInter,
      alignment: Alignment.centerRight,
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
