import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

// ignore: must_be_immutable
class MatchcardItemWidget extends StatelessWidget {
  MatchcardItemWidget({
    Key? key,
    this.onTapCardMatch,
  }) : super(
          key: key,
        );

  VoidCallback? onTapCardMatch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgLeaguePremierLeague,
              height: 24.adaptSize,
              width: 24.adaptSize,
              radius: BorderRadius.circular(
                4.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12.h,
                top: 3.v,
              ),
              child: Text(
                "Premier League",
                style: CustomTextStyles.titleMediumOnPrimaryBold,
              ),
            ),
            Container(
              // width: 65.h,
              margin: EdgeInsets.only(
                left: 8.h,
                top: 4.v,
                bottom: 3.v,
              ),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgIcon,
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                    margin: EdgeInsets.only(bottom: 1.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      "England",
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.v),
        GestureDetector(
          onTap:  onTapCardMatch,
          child: Column(
            children: [
              Container(
                decoration: AppDecoration.fillRed.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 48.h,
                            padding: EdgeInsets.symmetric(vertical: 6.v),
                            decoration: AppDecoration.fillDeepOrange,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 40.v,
                                  child: VerticalDivider(
                                    width: 3.h,
                                    thickness: 3.v,
                                    color: appTheme.red400,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.h,
                                    top: 4.v,
                                    bottom: 4.v,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "4’",
                                        style:
                                            CustomTextStyles.labelLargeRed400,
                                      ),
                                      SizedBox(height: 1.v),
                                      Text(
                                        "FT",
                                        style: theme.textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.h,
                              top: 8.v,
                              bottom: 8.v,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgThumbsUp,
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.h),
                                      child: Text( 
                                        "Liverpool",
                                        style: theme.textTheme.labelLarge,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.v),
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgThumbsUp,
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                    ),
                                    Text(
                                      "Aston",
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.v),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "3",
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                                SizedBox(height: 4.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 1.h),
                                  child: Text(
                                    "1",
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgSignal,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(
                        left: 29.h,
                        top: 18.v,
                        bottom: 18.v,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.v),
              Container(
                decoration: AppDecoration.fillRed.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                        vertical: 10.v,
                      ),
                      decoration: AppDecoration.fillDeepOrange,
                      child: Column(
                        children: [
                          Text(
                            "21:00",
                            style: theme.textTheme.labelLarge,
                          ),
                          SizedBox(height: 1.v),
                          Text(
                            "FT",
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // width: 79.h,
                      margin: EdgeInsets.only(
                        left: 8.h,
                        top: 8.v,
                        bottom: 8.v,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgThumbsUp,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                              ),
                              SizedBox(height: 4.v),
                              CustomImageView(
                                imagePath: ImageConstant.imgThumbsUp,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Liverpool",
                                  style: theme.textTheme.labelLarge,
                                ),
                                SizedBox(height: 2.v),
                                Text(
                                  "Aston Villa ",
                                  style: theme.textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.v),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "3",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                          SizedBox(height: 4.v),
                          Padding(
                            padding: EdgeInsets.only(left: 1.h),
                            child: Text(
                              "1",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgSignal,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.fromLTRB(28.h, 18.v, 12.h, 18.v),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.v),
              Container(
                decoration: AppDecoration.fillRed.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                        vertical: 10.v,
                      ),
                      decoration: AppDecoration.fillDeepOrange,
                      child: Column(
                        children: [
                          Text(
                            "21:00",
                            style: theme.textTheme.labelLarge,
                          ),
                          SizedBox(height: 1.v),
                          Text(
                            "FT",
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.h,
                        top: 8.v,
                        bottom: 8.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgThumbsUp,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.h),
                                child: Text(
                                  "Liverpool",
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.v),
                          Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgThumbsUp,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.h),
                                child: Text(
                                  "Aston Villa ",
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      imagePath: ImageConstant.imgSignalGray400,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(
                        top: 18.v,
                        right: 12.h,
                        bottom: 18.v,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


   ViewMatchDetailsPage(BuildContext context) {
  }
}
