import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Container(
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.h, vertical: 45.v),
                      child: Column(children: [
                        SizedBox(height: 23.v),
                        CustomImageView(
                            imagePath: ImageConstant.imgTellasportLogo,
                            height: 32.v,
                            width: 203.h),
                        SizedBox(height: 32.v),
                        Text("Register", style: theme.textTheme.headlineLarge),
                        SizedBox(height: 13.v),
                        _buildUsernameTextField(context),
                        SizedBox(height: 15.v),
                        _buildEmailTextField(context),
                        SizedBox(height: 15.v),
                        _buildPhoneNumberTextField(context),
                        SizedBox(height: 17.v),
                        _buildPasswordTextField(context),
                        SizedBox(height: 24.v),
                        CustomElevatedButton(
                            text: "Register",
                            margin: EdgeInsets.symmetric(horizontal: 4.h),
                            onPressed: () {
                              onTapRegister(context);
                            }),
                        SizedBox(height: 9.v),
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Already have an account? ",
                                  style:
                                      CustomTextStyles.titleSmallBluegray900_1),
                              TextSpan(
                                  text: "Sign in",
                                  style: CustomTextStyles.titleSmallPrimary)
                            ]),
                            textAlign: TextAlign.left),
                        SizedBox(height: 42.v),
                        CustomOutlinedButton(
                            text: "Sign in with Google",
                            margin: EdgeInsets.symmetric(horizontal: 4.h),
                            leftIcon: Container(
                                margin: EdgeInsets.only(right: 10.h),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgSocialMediaIcons,
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
                        SizedBox(height: 13.v),
                        Container(
                            width: 342.h,
                            margin: EdgeInsets.symmetric(horizontal: 7.h),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "By ",
                                      style: CustomTextStyles
                                          .titleSmallBluegray900_1),
                                  TextSpan(
                                      text: "signing up",
                                      style: CustomTextStyles
                                          .titleSmallBluegray900_1),
                                  TextSpan(
                                      text: ", you agree to ",
                                      style: CustomTextStyles
                                          .titleSmallBluegray900_1),
                                  TextSpan(
                                      text: "our",
                                      style: CustomTextStyles
                                          .titleSmallBluegray900_1),
                                  TextSpan(text: " "),
                                  TextSpan(
                                      text: "Terms of Service",
                                      style: CustomTextStyles.titleSmallBlue400),
                                  TextSpan(
                                      text: " and ",
                                      style: CustomTextStyles
                                          .titleSmallBluegray900_1),
                                  TextSpan(
                                      text: "Privacy Policy",
                                      style: CustomTextStyles.titleSmallBlue400),
                                  TextSpan(
                                      text: ".",
                                      style: CustomTextStyles
                                          .titleSmallBluegray900_1)
                                ]),
                                textAlign: TextAlign.center))
                      ]))),
            )));
  }

  /// Section Widget
  Widget _buildUsernameTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Username", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: userNameController,
              hintText: "Create a username",
              hintStyle: CustomTextStyles.titleSmallGray600)
        ]));
  }

  /// Section Widget
  Widget _buildEmailTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("E-mail ", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: emailController,
              hintText: "Enter your email",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.emailAddress)
        ]));
  }

  /// Section Widget
  Widget _buildPhoneNumberTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Phone number", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: phoneNumberController,
              hintText: "Enter your phone number",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.phone)
        ]));
  }

  /// Section Widget
  Widget _buildPasswordTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Create a password", style: theme.textTheme.titleSmall),
          SizedBox(height: 2.v),
          CustomTextFormField(
              controller: passwordController,
              hintText: "Enter your password",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              suffix: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 12.v, 8.h, 12.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgEyeoutline,
                      height: 24.adaptSize,
                      width: 24.adaptSize)),
              suffixConstraints: BoxConstraints(maxHeight: 48.v),
              obscureText: true,
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  /// Navigates to the signUpTwoScreen when the action is triggered.
  onTapRegister(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpTwoScreen);
  }

  /// Navigates to the signUpOneScreen when the action is triggered.
  onTapSignInWithApple(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpOneScreen);
  }
}
