import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:tellesports/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:tellesports/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

class CommunityChatScreen extends StatelessWidget {
  CommunityChatScreen({Key? key})
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
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildNovCounterStack(context),
              SizedBox(height: 2.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgProfilePicture,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              radius: BorderRadius.circular(
                                12.h,
                              ),
                              margin: EdgeInsets.only(top: 13.v),
                            ),
                            CustomElevatedButton(
                              height: 37.v,
                              width: 114.h,
                              text: "Short indeed",
                              margin: EdgeInsets.only(left: 2.h),
                              buttonStyle: CustomButtonStyles.fillGray,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumOnPrimary_1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.v),
                      Padding(
                        padding: EdgeInsets.only(left: 119.h),
                        child: Text(
                          "9. 41 AM".toUpperCase(),
                          style: CustomTextStyles.bodySmallGray600,
                        ),
                      ),
                      SizedBox(height: 19.v),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _buildBubble(context),
                                    SizedBox(height: 9.v),
                                    Container(
                                      width: 65.h,
                                      margin: EdgeInsets.only(right: 116.h),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 18.h,
                                        vertical: 1.v,
                                      ),
                                      decoration: AppDecoration.fillBluegray800
                                          .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder4,
                                      ),
                                      child: Text(
                                        "Today",
                                        style: CustomTextStyles
                                            .labelMediumWhiteA700,
                                      ),
                                    ),
                                    SizedBox(height: 10.v),
                                    Padding(
                                      padding: EdgeInsets.only(left: 34.h),
                                      child: _buildRightFrame(
                                        context,
                                        image: ImageConstant.imgRectangle230,
                                        text:
                                            "This is an image chat for bigger image with maximum height 214px",
                                      ),
                                    ),
                                    SizedBox(height: 3.v),
                                    Text(
                                      "9. 41 AM".toUpperCase(),
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    SizedBox(height: 19.v),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 26.h),
                                        child: Text(
                                          "Johnson",
                                          style: CustomTextStyles
                                              .labelLargeGray700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.v),
                                    _buildProfilePicture(context),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 2.h,
                                  top: 396.v,
                                  bottom: 322.v,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          ImageConstant.imgProfilePicture,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize,
                                      radius: BorderRadius.circular(
                                        12.h,
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    SizedBox(height: 4.v),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Sent",
                                        style:
                                            CustomTextStyles.labelMediumGray700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 19.v),
                      _buildFrame(context),
                      SizedBox(height: 3.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 54.h),
                          child: Text(
                            "9. 41 AM".toUpperCase(),
                            style: CustomTextStyles.bodySmallGray600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomElevatedButton(
                                height: 37.v,
                                width: 114.h,
                                text: "Short indeed",
                                buttonStyle: CustomButtonStyles.fillBlueTL6,
                                buttonTextStyle:
                                    CustomTextStyles.titleMediumOnPrimary_1,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgProfilePicture,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                radius: BorderRadius.circular(
                                  12.h,
                                ),
                                margin: EdgeInsets.only(
                                  left: 2.h,
                                  top: 13.v,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "9. 41 AM".toUpperCase(),
                                style: CustomTextStyles.bodySmallGray600,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.h),
                                child: Text(
                                  "Sent",
                                  style: CustomTextStyles.labelMediumGray600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 9.v),
                      _buildUiBottomBar(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   
  Widget _buildNovCounterStack(BuildContext context) {
    return SizedBox(
      height: 87.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                left: 160.h,
                right: 160.h,
                bottom: 25.v,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 18.h,
                vertical: 1.v,
              ),
              decoration: AppDecoration.fillBluegray800.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder4,
              ),
              child: Text(
                "24 Nov",
                style: CustomTextStyles.labelMediumWhiteA700,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 46.h),
              child: Text(
                "Johnson",
                style: CustomTextStyles.labelLargeGray700,
              ),
            ),
          ),
          CustomAppBar(
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
                bottom: 4.v,
              ),
              child: Row(
                children: [
                  AppbarTitleCircleimage(
                    imagePath: ImageConstant.imgAvatar,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Column(
                      children: [
                        AppbarSubtitleTwo(
                          text: "Pixsellz Team ",
                        ),
                        AppbarSubtitleFour(
                          text: "120 members",
                          margin: EdgeInsets.only(right: 28.h),
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
          ),
        ],
      ),
    );
  }

   
  Widget _buildBubble(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgProfilePicture,
                height: 24.adaptSize,
                width: 24.adaptSize,
                radius: BorderRadius.circular(
                  12.h,
                ),
                margin: EdgeInsets.only(top: 73.v),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Johnson",
                        style: CustomTextStyles.labelLargeGray700,
                      ),
                      SizedBox(height: 2.v),
                      Container(
                        width: 290.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.h,
                          vertical: 5.v,
                        ),
                        decoration: AppDecoration.fillGray.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderTL10,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 2.v),
                            Container(
                              width: 261.h,
                              margin: EdgeInsets.only(right: 12.h),
                              child: Text(
                                "Medium to long text v1 template is used if the wording content’s text-width is wider than 274px.",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.titleMediumOnPrimary_1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.v),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "9. 41 AM".toUpperCase(),
              style: CustomTextStyles.bodySmallGray600,
            ),
          ),
        ],
      ),
    );
  }

   
  Widget _buildProfilePicture(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgProfilePicture,
            height: 24.adaptSize,
            width: 24.adaptSize,
            radius: BorderRadius.circular(
              12.h,
            ),
            margin: EdgeInsets.only(
              top: 244.v,
              bottom: 16.v,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2.h),
              child: Column(
                children: [
                  _buildRightFrame(
                    context,
                    image: ImageConstant.imgRectangle230214x282,
                    text:
                        "This is an image chat for bigger image with maximum height 214px",
                  ),
                  SizedBox(height: 1.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "9. 41AM".toUpperCase(),
                      style: CustomTextStyles.bodySmallGray600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

   
  Widget _buildFrame(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 54.h,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgProfilePicture,
            height: 24.adaptSize,
            width: 24.adaptSize,
            radius: BorderRadius.circular(
              12.h,
            ),
            margin: EdgeInsets.only(top: 158.v),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Johnson",
                    style: CustomTextStyles.labelLargeGray700,
                  ),
                  SizedBox(height: 2.v),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    decoration: AppDecoration.fillGray.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 3.v),
                        Container(
                          padding: EdgeInsets.all(4.h),
                          decoration: AppDecoration.fillBlue5001.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 6.v,
                                  bottom: 4.v,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 145.h,
                                          child: Text(
                                            "Lorem Ipsum Dolor Sit Amet Consetteur",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.titleSmall,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 130.h,
                                          child: Text(
                                            "Lorem ipsum dolor sit amet consectetur. Diam tempus volutpat consectetur ...",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .labelMediumGray700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.v),
                                    Text(
                                      "sportybet.com",
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgRectangle236,
                                height: 104.adaptSize,
                                width: 104.adaptSize,
                                radius: BorderRadius.circular(
                                  6.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3.v),
                        Container(
                          width: 165.h,
                          margin: EdgeInsets.only(left: 5.h),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Visit ",
                                  style: CustomTextStyles.titleMediumOnPrimary,
                                ),
                                TextSpan(
                                  text: "sportybet.com/wqw3qeqwqws/dqwd",
                                  style: CustomTextStyles.titleMediumBlue400,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

   
  Widget _buildUiBottomBar(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(20.h, 9.v, 20.h, 10.v),
      decoration: AppDecoration.outlineGray400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgAttachFile,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(
              top: 5.v,
              bottom: 31.v,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 12.h,
                bottom: 26.v,
              ),
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
              bottom: 31.v,
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRightFrame(
    BuildContext context, {
    required String image,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.all(4.h),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: image,
            height: 214.v,
            width: 282.h,
            radius: BorderRadius.circular(
              8.h,
            ),
          ),
          SizedBox(height: 4.v),
          Container(
            width: 259.h,
            margin: EdgeInsets.only(
              left: 4.h,
              right: 18.h,
            ),
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleMediumOnPrimary_1.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
