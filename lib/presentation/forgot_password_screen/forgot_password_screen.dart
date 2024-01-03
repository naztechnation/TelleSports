import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(children: [
                      Text("Forgot Password",
                          style: theme.textTheme.headlineLarge),
                      SizedBox(height: 9.v),
                      Container(
                          width: 339.h,
                          margin: EdgeInsets.symmetric(horizontal: 9.h),
                          child: Text(
                              "No worries! Enter your email address below and we will send you a code to reset password.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.labelLargeBluegray700)),
                      SizedBox(height: 31.v),
                      _buildTextField(context),
                      SizedBox(height: 32.v),
                      CustomElevatedButton(
                          text: "Send reset email",
                          margin: EdgeInsets.symmetric(horizontal: 4.h),
                          onPressed: () {
                            onTapSendResetEmail(context);
                          }),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 389.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(24.h, 20.v, 350.h, 20.v)));
  }

  /// Section Widget
  Widget _buildTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("E-mail or phone number", style: theme.textTheme.titleSmall),
          SizedBox(height: 2.v),
          CustomTextFormField(
              controller: phoneNumberController,
              hintText: "Enter your email or phone number",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress)
        ]));
  }


  onTapSendResetEmail(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.verifyAccountScreen);
  }
}
