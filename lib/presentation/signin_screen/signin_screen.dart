import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 69.v),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                              imagePath: ImageConstant.imgTellasportLogo,
                              height: 32.v,
                              width: 203.h),
                          SizedBox(height: 44.v),
                          Text("Welcome  back!",
                              style: theme.textTheme.headlineLarge),
                          SizedBox(height: 30.v),
                          _buildEmailOrPhoneSection(context),
                          SizedBox(height: 11.v),
                          _buildIncorrectPasswordSection(context),
                          SizedBox(height: 13.v),
                          Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () {
                                    onTapTxtForgotPassword(context);
                                  },
                                  child: Text("Forgot Password?",
                                      style: CustomTextStyles
                                          .titleSmallBlue400_1
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline)))),
                          SizedBox(height: 29.v),
                          CustomElevatedButton(
                              text: "Login",
                              margin: EdgeInsets.symmetric(horizontal: 4.h)),
                          Spacer(),
                          Text("or login with",
                              style: CustomTextStyles.labelLargeGray600),
                          SizedBox(height: 11.v),
                          CustomOutlinedButton(
                              text: "Sign in with Google",
                              margin: EdgeInsets.symmetric(horizontal: 4.h),
                              leftIcon: Container(
                                  margin: EdgeInsets.only(right: 10.h),
                                  child: CustomImageView(
                                      imagePath:
                                          ImageConstant.imgSocialMediaIcons,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize))),
                          SizedBox(height: 13.v),
                          CustomOutlinedButton(
                              text: "Sign in with Apple",
                              margin: EdgeInsets.symmetric(horizontal: 4.h),
                              leftIcon: Container(
                                  margin: EdgeInsets.only(right: 10.h),
                                  child: CustomImageView(
                                      imagePath: ImageConstant
                                          .imgSocialMediaIconsOnprimary,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize)),
                              onPressed: () {
                                onTapSignInWithApple(context);
                              }),
                          SizedBox(height: 10.v)
                        ])))));
  }

  /// Section Widget
  Widget _buildEmailOrPhoneSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("E-mail or phone number", style: theme.textTheme.titleSmall),
          SizedBox(height: 2.v),
          CustomTextFormField(
              controller: phoneNumberController,
              hintText: "Enter your email or phone number",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.emailAddress)
        ]));
  }

  /// Section Widget
  Widget _buildPasswordSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Password", style: theme.textTheme.titleSmall),
      SizedBox(height: 3.v),
      CustomTextFormField(
          controller: passwordController,
          hintText: "************",
          hintStyle: CustomTextStyles.titleSmallRed600,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          suffix: Container(
              margin: EdgeInsets.fromLTRB(30.h, 12.v, 8.h, 12.v),
              child: CustomImageView(
                  imagePath: ImageConstant.imgEyeoutlineBlueGray900,
                  height: 24.adaptSize,
                  width: 24.adaptSize)),
          suffixConstraints: BoxConstraints(maxHeight: 48.v),
          obscureText: true,
          contentPadding: EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
    ]);
  }

  /// Section Widget
  Widget _buildIncorrectPasswordSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildPasswordSection(context),
          SizedBox(height: 4.v),
          Padding(
              padding: EdgeInsets.only(right: 98.h),
              child: Row(children: [
                CustomImageView(
                    imagePath: ImageConstant.imgInfoOutline,
                    height: 16.adaptSize,
                    width: 16.adaptSize),
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                        "Incorrect password. Please check your password.",
                        style: CustomTextStyles.labelMediumRed600))
              ]))
        ]));
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
  }

  /// Navigates to the convertBetcodesoneContainerScreen when the action is triggered.
  onTapSignInWithApple(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.convertBetcodesoneContainerScreen);
  }
}
