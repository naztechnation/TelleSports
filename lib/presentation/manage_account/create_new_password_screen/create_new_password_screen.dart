import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../utils/navigator/page_navigator.dart';
import '../../auth/signin_screen/signin_screen.dart';

// ignore_for_file: must_be_immutable
class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

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
                      Text("Create New Password",
                          style: theme.textTheme.headlineLarge),
                      SizedBox(height: 14.v),
                      Text("Please enter and confirm your new password.",
                          style: CustomTextStyles.titleSmallBluegray900),
                      Text("You will need to login after you reset.",
                          style: CustomTextStyles.titleSmallBluegray900),
                      SizedBox(height: 29.v),
                      _buildPasswordTextField(context),
                      SizedBox(height: 11.v),
                      _buildConfirmPasswordTextField(context),
                      SizedBox(height: 32.v),
                      CustomElevatedButton(
                          text: "Create Password",
                          margin: EdgeInsets.symmetric(horizontal: 4.h),
                          onPressed: () {
                            onTapCreatePassword(context);
                          }),
                      SizedBox(height: 5.v)
                    ])))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 389.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(24.h, 20.v, 350.h, 20.v)));
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: passwordController,
              hintText: "*************",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.visiblePassword,
              suffix: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 12.v, 8.h, 12.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgEyeoutlineBlueGray900,
                      height: 24.adaptSize,
                      width: 24.adaptSize)),
              suffixConstraints: BoxConstraints(maxHeight: 48.v),
              obscureText: true,
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

 
  Widget _buildConfirmPasswordTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Confirm Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: confirmpasswordController,
              hintText: "*************",
              hintStyle: CustomTextStyles.titleSmallGray600,
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
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  onTapCreatePassword(BuildContext context) {
       AppNavigator.pushAndReplacePage(context, page: SigninScreen());
;
  }
}
