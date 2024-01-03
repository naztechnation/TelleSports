import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpOneScreen extends StatelessWidget {
  SignUpOneScreen({Key? key}) : super(key: key);

  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.only(left: 16.h, top: 69.v, right: 16.h),
                    child: Column(children: [
                      CustomImageView(
                          imagePath: ImageConstant.imgTellasportLogo,
                          height: 32.v,
                          width: 203.h),
                      SizedBox(height: 31.v),
                      Text("Add a phone number",
                          style: theme.textTheme.headlineLarge),
                      SizedBox(height: 10.v),
                      Container(
                          width: 303.h,
                          margin: EdgeInsets.symmetric(horizontal: 27.h),
                          child: Text(
                              "Complete your registration by adding a phone number to your account. ",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.titleSmallBluegray900)),
                      SizedBox(height: 28.v),
                      _buildPhoneNumberSection(context),
                      SizedBox(height: 32.v),
                      CustomElevatedButton(
                          text: "Verify Number",
                          margin: EdgeInsets.symmetric(horizontal: 4.h),
                          onPressed: () {
                            onTapVerifyNumber(context);
                          }),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  Widget _buildPhoneNumberSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Phone number", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: phoneNumberController,
              hintText: "Enter your phone number",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.phone)
        ]));
  }

  /// Navigates to the signUpTwoScreen when the action is triggered.
  onTapVerifyNumber(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpTwoScreen);
  }
}
