import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class CommunityInfoTwoPage extends StatefulWidget {
  const CommunityInfoTwoPage({Key? key})
      : super(
          key: key,
        );

  @override
  CommunityInfoTwoPageState createState() => CommunityInfoTwoPageState();
}

class CommunityInfoTwoPageState extends State<CommunityInfoTwoPage>
    with AutomaticKeepAliveClientMixin<CommunityInfoTwoPage> {
  TextEditingController vectorController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: vectorController,
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
                      _buildUserProfileSection(context),
                      SizedBox(height: 24.v),
                      CustomElevatedButton(
                        text: "Leave community",
                        buttonStyle: CustomButtonStyles.fillRedTL8,
                      ),
                      SizedBox(height: 16.v),
                      CustomOutlinedButton(
                        text: "Report community",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   
  Widget _buildUserProfileSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "120 Members",
            style: CustomTextStyles.titleMediumBluegray900,
          ),
          SizedBox(height: 8.v),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 8.v,
              );
            },
            itemCount: 8,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
