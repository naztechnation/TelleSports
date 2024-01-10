import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_six.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:tellesports/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';

class ViewLivescoresDetailsScreen extends StatelessWidget {
  ViewLivescoresDetailsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 20.v),
              _buildTopnavMatchDetails(context),
              SizedBox(height: 16.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.v),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 6.v,
                          ),
                          decoration: AppDecoration.fillWhiteA.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgUser,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                alignment: Alignment.center,
                              ),
                              SizedBox(height: 6.v),
                              _buildContent(context),
                              CustomImageView(
                                imagePath: ImageConstant.imgTail,
                                height: 16.v,
                                width: 24.h,
                                alignment: Alignment.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 55.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 19.v),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "In: Pable Rosario",
                                              style: theme.textTheme.labelLarge,
                                            ),
                                          ),
                                          SizedBox(height: 1.v),
                                          Text(
                                            "Out: Hicham Boudaoui",
                                            style: CustomTextStyles
                                                .labelMediumGray700,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 18.h,
                                        top: 2.v,
                                      ),
                                      child: _buildTail(
                                        context,
                                        leftIcon: ImageConstant.imgLeftIcon,
                                        description: "86’",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.v),
                              Padding(
                                padding: EdgeInsets.only(left: 51.h),
                                child: _buildTimeline(
                                  context,
                                  title: "In: Evann Guessand",
                                  description: "Out: Gaetan Laborde",
                                  televisionImage: ImageConstant.imgLeftIcon,
                                  description1: "86’",
                                ),
                              ),
                              SizedBox(height: 4.v),
                              Padding(
                                padding: EdgeInsets.only(right: 31.h),
                                child: _buildTimeline2(
                                  context,
                                  description: "84’",
                                  title: "In: Marvin Sanaya",
                                  description1: "Out: Loubadhe Abakar Sylla",
                                ),
                              ),
                              SizedBox(height: 3.v),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 65.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.v),
                                        child: _buildTail(
                                          context,
                                          leftIcon: ImageConstant.imgTelevision,
                                          description: "84’",
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 18.h,
                                          bottom: 19.v,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ibrahima Sissoko",
                                              style: theme.textTheme.labelLarge,
                                            ),
                                            SizedBox(height: 1.v),
                                            Text(
                                              "Foul",
                                              style: CustomTextStyles
                                                  .labelMediumGray700,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 3.v),
                              Padding(
                                padding: EdgeInsets.only(left: 51.h),
                                child: _buildTimeline(
                                  context,
                                  title: "In: Evann Guessand",
                                  description: "Out: Gaetan Laborde",
                                  televisionImage:
                                      ImageConstant.imgTelevisionRed400,
                                  description1: "83’",
                                ),
                              ),
                              SizedBox(height: 3.v),
                              Padding(
                                padding: EdgeInsets.only(left: 51.h),
                                child: _buildTimeline(
                                  context,
                                  title: "In: Evann Guessand",
                                  description: "Out: Gaetan Laborde",
                                  televisionImage: ImageConstant.imgLeftIcon,
                                  description1: "82’",
                                ),
                              ),
                              SizedBox(height: 3.v),
                              Padding(
                                padding: EdgeInsets.only(left: 51.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 39.v),
                                      child: _buildTimeline1(
                                        context,
                                        titleText: "In: Evann Guessand",
                                        descriptionText: "Out: Gaetan Laborde",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 11.h,
                                        top: 2.v,
                                      ),
                                      child: Column(
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant
                                                .imgLeftIconWhiteA700,
                                            height: 16.adaptSize,
                                            width: 16.adaptSize,
                                          ),
                                          SizedBox(height: 5.v),
                                          Text(
                                            "77’",
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          SizedBox(height: 3.v),
                                          Container(
                                            width: 29.h,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.h,
                                              vertical: 1.v,
                                            ),
                                            decoration:
                                                AppDecoration.fillRed.copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder8,
                                            ),
                                            child: Text(
                                              "2-0",
                                              style: CustomTextStyles
                                                  .bodySmallInterOnPrimaryContainer,
                                            ),
                                          ),
                                          SizedBox(height: 4.v),
                                          CustomImageView(
                                            imagePath: ImageConstant.imgTail,
                                            height: 10.v,
                                            width: 1.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.v),
                              Padding(
                                padding: EdgeInsets.only(left: 51.h),
                                child: _buildTimeline(
                                  context,
                                  title: "In: Evann Guessand",
                                  description: "Out: Gaetan Laborde",
                                  televisionImage: ImageConstant.imgLeftIcon,
                                  description1: "68’",
                                ),
                              ),
                              SizedBox(height: 4.v),
                              Padding(
                                padding: EdgeInsets.only(right: 31.h),
                                child: _buildTimeline2(
                                  context,
                                  description: "64’",
                                  title: "In: Marvin Sanaya",
                                  description1: "Out: Loubadhe Abakar Sylla",
                                ),
                              ),
                              SizedBox(height: 4.v),
                              _buildContent1(context),
                              CustomImageView(
                                imagePath: ImageConstant.imgTail,
                                height: 16.v,
                                width: 24.h,
                                alignment: Alignment.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 51.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 39.v),
                                      child: _buildTimeline1(
                                        context,
                                        titleText: "In: Evann Guessand",
                                        descriptionText: "Out: Gaetan Laborde",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 12.h,
                                        top: 2.v,
                                      ),
                                      child: Column(
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant
                                                .imgLeftIconWhiteA700,
                                            height: 16.adaptSize,
                                            width: 16.adaptSize,
                                          ),
                                          SizedBox(height: 5.v),
                                          Text(
                                            "45+2’",
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          SizedBox(height: 3.v),
                                          Container(
                                            width: 28.h,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.h,
                                              vertical: 1.v,
                                            ),
                                            decoration:
                                                AppDecoration.fillRed.copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder8,
                                            ),
                                            child: Text(
                                              "1-0",
                                              style: CustomTextStyles
                                                  .bodySmallInterOnPrimaryContainer,
                                            ),
                                          ),
                                          SizedBox(height: 4.v),
                                          CustomImageView(
                                            imagePath: ImageConstant.imgTail,
                                            height: 10.v,
                                            width: 1.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.v),
                              Padding(
                                padding: EdgeInsets.only(left: 51.h),
                                child: _buildTimeline(
                                  context,
                                  title: "In: Evann Guessand",
                                  description: "Out: Gaetan Laborde",
                                  televisionImage: ImageConstant.imgTelevision,
                                  description1: "6’",
                                ),
                              ),
                              SizedBox(height: 10.v),
                              CustomImageView(
                                imagePath: ImageConstant.imgUser,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.v),
                        _buildLegend(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

   
  Widget _buildTopnavMatchDetails(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillWhiteA,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 6.v),
          CustomAppBar(
            height: 60.v,
            leadingWidth: 44.h,
            leading: AppbarLeadingImage(
              onTap: (){
                Navigator.pop(context);
              },
              imagePath: ImageConstant.imgArrowBack,
              margin: EdgeInsets.only(
                left: 20.h,
                top: 3.v,
                bottom: 5.v,
              ),
            ),
            centerTitle: true,
            title: Column(
              children: [
                AppbarSubtitleThree(
                  text: "English Premier League",
                ),
                AppbarSubtitleSix(
                  text: "Sunday, 3 September 2023 at 20:00",
                  margin: EdgeInsets.symmetric(horizontal: 5.h),
                ),
              ],
            ),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgShare,
                margin: EdgeInsets.fromLTRB(20.h, 3.v, 20.h, 5.v),
              ),
            ],
          ),
          SizedBox(height: 3.v),
          Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillDeeporange50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumn(
                  context,
                  screenNameText: "Liverpool",
                  signalImage: ImageConstant.imgSignal,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.v),
                  child: Column(
                    children: [
                      Text(
                        "Full Time",
                        style: CustomTextStyles.labelMediumGray700,
                      ),
                      Text(
                        "3-0",
                        style: CustomTextStyles.titleMediumGray800,
                      ),
                      Text(
                        "HT 2-0",
                        style: CustomTextStyles.labelMediumGray700,
                      ),
                    ],
                  ),
                ),
                _buildColumn(
                  context,
                  screenNameText: "Aston Villa",
                  signalImage: ImageConstant.imgSignalGray50001,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   
  Widget _buildContent(BuildContext context) {
    return Container(
      width: 374.h,
      padding: EdgeInsets.symmetric(
        horizontal: 152.h,
        vertical: 5.v,
      ),
      decoration: AppDecoration.fillRed400.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Text(
        "FT 2-0",
        style: CustomTextStyles.titleSmallInterWhiteA700,
      ),
    );
  }

   
  Widget _buildContent1(BuildContext context) {
    return Container(
      width: 374.h,
      padding: EdgeInsets.symmetric(
        horizontal: 153.h,
        vertical: 5.v,
      ),
      decoration: AppDecoration.fillRed400.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Text(
        "FT 1-0",
        style: CustomTextStyles.titleSmallInterWhiteA700,
      ),
    );
  }

   
  Widget _buildLegend(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 15.v,
      ),
      decoration: AppDecoration.fillRed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLeftIconRed400,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
                          SizedBox(width: 6),

              Text(
                "Substitution",
                style: theme.textTheme.labelMedium,
              ),
          SizedBox(width: 12),

              CustomImageView(
                imagePath: ImageConstant.imgTelevisionRed400,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
                          SizedBox(width: 6),

              Text(
                "Red Card",
                style: theme.textTheme.labelMedium,
              ),
          SizedBox(width: 12),

              CustomImageView(
                imagePath: ImageConstant.imgTelevision,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
                          SizedBox(width: 6),
              
              Text(
                "Yellow Card",
                style: theme.textTheme.labelMedium,
              ),
          SizedBox(width: 12),

              CustomImageView(
                imagePath: ImageConstant.imgClose,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
                          SizedBox(width: 6),

              Text(
                "Corner",
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
          SizedBox(height: 10.v),
          Wrap(
            children: [
              CustomImageView(
                    imagePath: ImageConstant.imgLeftIconWhiteA700,
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Goal",
                    style: theme.textTheme.labelMedium,
                  ),
          SizedBox(width: 12),

                   CustomImageView(
                          imagePath: ImageConstant.imgLeftIconWhiteA70016x16,
                          height: 16.adaptSize,
                          width: 16.adaptSize,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Own-goal",
                          style: theme.textTheme.labelMedium,
                        ),
          SizedBox(width: 12),

                        CustomImageView(
                              imagePath: ImageConstant.imgLeftIcon16x16,
                              height: 16.adaptSize,
                              width: 16.adaptSize,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Penalty",
                              style: theme.textTheme.labelMedium,
                            ),
          SizedBox(width: 12),

              CustomImageView(
                            imagePath: ImageConstant.imgLeftIcon1,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Penalty Missed",
                            style: theme.textTheme.labelMedium,
                          ),
            ],
          ),
        ],
      ),
    );
  }

   
  // Widget _buildBottomBar(BuildContext context) {
  //   return CustomBottomBar(
  //     onChanged: (BottomBarEnum type) {
  //       // Navigator.pushNamed(
  //       //     navigatorKey.currentContext!, getCurrentRoute(type));
  //     },
  //   );
  // }

  /// Common widget
  Widget _buildColumn(
    BuildContext context, {
    required String screenNameText,
    required String signalImage,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 43.h,
        vertical: 8.v,
      ),
      decoration: AppDecoration.fillRed,
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgThumbsUp,
            height: 40.adaptSize,
            width: 40.adaptSize,
          ),
          SizedBox(height: 3.v),
          Text(
            screenNameText,
            style: CustomTextStyles.titleSmallBluegray900.copyWith(
              color: appTheme.blueGray900,
            ),
          ),
          SizedBox(height: 3.v),
          CustomImageView(
            imagePath: signalImage,
            height: 16.adaptSize,
            width: 16.adaptSize,
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildTail(
    BuildContext context, {
    required String leftIcon,
    required String description,
  }) {
    return Column(
      children: [
        CustomImageView(
          imagePath: leftIcon,
          height: 16.adaptSize,
          width: 16.adaptSize,
        ),
        SizedBox(height: 5.v),
        Text(
          description,
          style: theme.textTheme.labelMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: 3.v),
        CustomImageView(
          imagePath: ImageConstant.imgTail,
          height: 10.v,
          width: 1.h,
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildTimeline(
    BuildContext context, {
    required String title,
    required String description,
    required String televisionImage,
    required String description1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 19.v),
          child: Column(
            children: [
              Text(
                title,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 1.v),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  description,
                  style: CustomTextStyles.labelMediumGray700.copyWith(
                    color: appTheme.gray700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 18.h,
            top: 2.v,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: televisionImage,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
              SizedBox(height: 5.v),
              Text(
                description1,
                style: theme.textTheme.labelMedium!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 3.v),
              CustomImageView(
                imagePath: ImageConstant.imgTail,
                height: 10.v,
                width: 1.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline1(
    BuildContext context, {
    required String titleText,
    required String descriptionText,
  }) {
    return Column(
      children: [
        Text(
          titleText,
          style: theme.textTheme.labelLarge!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: 1.v),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            descriptionText,
            style: CustomTextStyles.labelMediumGray700.copyWith(
              color: appTheme.gray700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline2(
    BuildContext context, {
    required String description,
    required String title,
    required String description1,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLeftIcon,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
              SizedBox(height: 5.v),
              Text(
                description,
                style: theme.textTheme.labelMedium!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 3.v),
              CustomImageView(
                imagePath: ImageConstant.imgTail,
                height: 10.v,
                width: 1.h,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 18.h,
            bottom: 18.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 1.v),
              Text(
                description1,
                style: CustomTextStyles.labelMediumGray700.copyWith(
                  color: appTheme.gray700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
