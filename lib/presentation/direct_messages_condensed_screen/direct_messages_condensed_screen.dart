import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:tellesports/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:tellesports/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

class DirectMessagesCondensedScreen extends StatelessWidget {
  DirectMessagesCondensedScreen({Key? key})
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: Container(
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
              ),
              SizedBox(height: 9.v),
              _buildBubbleColumn1(context),
              SizedBox(height: 19.v),
              _buildBubbleColumn2(context),
              SizedBox(height: 19.v),
              Padding(
                padding: EdgeInsets.only(left: 46.h),
                child: Text(
                  "Johnson",
                  style: CustomTextStyles.labelLargeGray700,
                ),
              ),
              SizedBox(height: 2.v),
              _buildProfilePictureRow(context),
              SizedBox(height: 20.v),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(height: 3.v),
                      _buildFrame(
                        context,
                        timeText: "9. 41 AM",
                        sentText: "Sent",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 9.v),
              _buildUiBottomBarRow(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
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
          top: 44.v,
          bottom: 4.v,
        ),
        child: Row(
          children: [
            AppbarTitleCircleimage(
              imagePath: ImageConstant.imgDisplayPicture36x36,
            ),
            AppbarSubtitleTwo(
              text: "Joshua11",
              margin: EdgeInsets.only(
                left: 8.h,
                top: 7.v,
                bottom: 7.v,
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

  /// Section Widget
  Widget _buildBubbleColumn1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.h),
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
                margin: EdgeInsets.only(top: 31.v),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Johnson",
                      style: CustomTextStyles.labelLargeGray700,
                    ),
                    SizedBox(height: 2.v),
                    CustomElevatedButton(
                      height: 37.v,
                      width: 114.h,
                      text: "Short indeed",
                      buttonStyle: CustomButtonStyles.fillGray,
                      buttonTextStyle: CustomTextStyles.titleMediumOnPrimary_1,
                    ),
                  ],
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

  /// Section Widget
  Widget _buildBubbleColumn2(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
          left: 56.h,
          right: 20.h,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 5.v,
                    ),
                    decoration: AppDecoration.fillBlue50.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL101,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 2.v),
                        Container(
                          width: 257.h,
                          margin: EdgeInsets.only(right: 16.h),
                          child: Text(
                            "Medium to long text v1 template is used if the wording/text content’s width is wider than 274px.",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.titleMediumOnPrimary_1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgProfilePicture,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  radius: BorderRadius.circular(
                    12.h,
                  ),
                  margin: EdgeInsets.only(top: 55.v),
                ),
              ],
            ),
            SizedBox(height: 3.v),
            _buildFrame(
              context,
              timeText: "9. 41 AM",
              sentText: "Sent",
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProfilePictureRow(BuildContext context) {
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
            margin: EdgeInsets.only(
              top: 140.v,
              bottom: 18.v,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2.h),
              child: Column(
                children: [
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
                                        style:
                                            CustomTextStyles.labelMediumGray700,
                                      ),
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
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUiBottomBarRow(BuildContext context) {
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
  Widget _buildFrame(
    BuildContext context, {
    required String timeText,
    required String sentText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          timeText,
          style: CustomTextStyles.bodySmallGray600.copyWith(
            color: appTheme.gray600,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.h),
          child: Text(
            sentText,
            style: CustomTextStyles.labelMediumGray600.copyWith(
              color: appTheme.gray600,
            ),
          ),
        ),
      ],
    );
  }
}
