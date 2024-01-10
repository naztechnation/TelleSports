import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:tellesports/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:tellesports/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

class CommunityChatEmptyStateScreen extends StatelessWidget {
  CommunityChatEmptyStateScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.lime50,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 17.v),
              Container(
                width: 65.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 18.h,
                  vertical: 1.v,
                ),
                decoration: AppDecoration.fillBluegray800.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                ),
                child: Text(
                  "Today",
                  style: CustomTextStyles.labelMediumWhiteA700,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: _buildUiBottomBar(context),
      ),
    );
  }

   
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 84.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBackBlue800,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 10.v,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(
          left: 12.h,
          top: 43.v,
          bottom: 1.v,
        ),
        child: Row(
          children: [
            AppbarTitleCircleimage(
              imagePath: ImageConstant.imgAvatar,
              margin: EdgeInsets.only(bottom: 2.v),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.h),
              child: Column(
                children: [
                  AppbarSubtitleTwo(
                    text: "Pixsellz Team ",
                  ),
                  SizedBox(height: 1.v),
                  AppbarSubtitleFour(
                    text: "John is typing",
                    margin: EdgeInsets.only(right: 25.h),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMoreVert,
          margin: EdgeInsets.fromLTRB(20.h, 50.v, 20.h, 10.v),
        ),
      ],
      styleType: Style.bgOutline,
    );
  }

   
  Widget _buildUiBottomBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 36.v,
      ),
      decoration: AppDecoration.outlineGray4001,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgAttachFile,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 5.v),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: CustomTextFormField(
                controller: messageController,
                hintText: "Type a message...",
                hintStyle: CustomTextStyles.titleSmallGray50001,
                textInputAction: TextInputAction.done,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 7.v,
                ),
                borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL17,
                filled: true,
                fillColor: appTheme.gray100,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgSend,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(
              left: 12.h,
              top: 5.v,
              bottom: 5.v,
            ),
          ),
        ],
      ),
    );
  }
}
