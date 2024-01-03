import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpTwoScreen extends StatelessWidget {
  SignUpTwoScreen({Key? key}) : super(key: key);

  TextEditingController enterDigitCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 16.h, top: 69.v, right: 16.h),
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgTellasportLogo,
                      height: 32.v,
                      width: 203.h),
                  SizedBox(height: 30.v),
                  Text("Verify Account", style: theme.textTheme.headlineLarge),
                  SizedBox(height: 5.v),
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Code has been send to ",
                            style: CustomTextStyles.titleSmallBluegray900_1),
                        TextSpan(
                            text: "+23498982993992",
                            style: CustomTextStyles.titleSmallBlue800)
                      ]),
                      textAlign: TextAlign.left),
                  Text("Enter the code to verify your account.",
                      style: CustomTextStyles.titleSmallBluegray900),
                  SizedBox(height: 29.v),
                  _buildTextFieldSection(context),
                  SizedBox(height: 12.v),
                  Padding(
                      padding: EdgeInsets.only(left: 20.h, right: 20.h),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(bottom: 1.v),
                                child: Text("Didn’t Receive Code?",
                                    style: theme.textTheme.bodyMedium)),
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Text("Resend Code",
                                      style: CustomTextStyles
                                          .titleSmallPoppinsBlue400
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline))),
                            )
                          ])),
                  SizedBox(height: 7.v),
                  Text("Resend code in 00:59",
                      style: theme.textTheme.bodyMedium),
                  SizedBox(height: 32.v),
                  CustomElevatedButton(
                      text: "Verify Account",
                      margin: EdgeInsets.symmetric(horizontal: 4.h),
                      onPressed: () {
                        onTapVerifyAccount(context);
                      }),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  Widget _buildTextFieldSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Enter Code", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: enterDigitCodeController,
              hintText: "Enter 6-digit code",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done)
        ]));
  }

  /// Navigates to the convertBetcodesoneContainerScreen when the action is triggered.
  onTapVerifyAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.convertBetcodesoneContainerScreen);
  }
}
