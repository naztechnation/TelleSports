import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/auth/signin_screen/signin_screen.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../utils/navigator/page_navigator.dart';
import '../create_new_password_screen/create_new_password_screen.dart';

// ignore_for_file: must_be_immutable
class VerifyAccountScreen extends StatelessWidget {
  VerifyAccountScreen({Key? key}) : super(key: key);

  TextEditingController enterDigitCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(children: [
                  Text("Verify Account", style: theme.textTheme.headlineLarge),
                  SizedBox(height: 5.v),
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Code has been send to ",
                            style: CustomTextStyles.titleSmallBluegray900_1),
                        TextSpan(
                            text: "john@gmail.com",
                            style: CustomTextStyles.titleSmallBlue800)
                      ]),
                      textAlign: TextAlign.left),
                  Text("Enter the code to verify your account.",
                      style: CustomTextStyles.titleSmallBluegray900),
                  SizedBox(height: 29.v),
                  _buildTextField(context),
                  SizedBox(height: 12.v),
                  Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 389.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(24.h, 20.v, 350.h, 20.v),
            onTap: (){
              Navigator.pop(context);
            },
            ));
  }

  Widget _buildTextField(BuildContext context) {
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

  onTapVerifyAccount(BuildContext context) {

    AppNavigator.pushAndStackPage(context, page: CreateNewPasswordScreen());
  }
}
