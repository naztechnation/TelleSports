import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key})
      : super(
          key: key,
        );

  @override
  UserInfoPageState createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage>
    with AutomaticKeepAliveClientMixin<UserInfoPage> {
  TextEditingController notificationsvalueController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              SizedBox(height: 36.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: notificationsvalueController,
                      hintText: "Notifications",
                      textInputAction: TextInputAction.done,
                      suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 19.v, 10.h, 19.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgVectorBlue400,
                          height: 10.v,
                          width: 20.h,
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 48.v,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 8.h,
                        top: 14.v,
                        bottom: 14.v,
                      ),
                      borderDecoration: TextFormFieldStyleHelper.outlineBlack,
                      filled: true,
                      fillColor: appTheme.whiteA700,
                    ),
                    SizedBox(height: 24.v),
                    CustomElevatedButton(
                      text: "Block",
                      buttonStyle: CustomButtonStyles.fillRedTL8,
                    ),
                    SizedBox(height: 16.v),
                    CustomOutlinedButton(
                      text: "Report user",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
