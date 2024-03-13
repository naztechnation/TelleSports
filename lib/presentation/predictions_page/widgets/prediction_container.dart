import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/res/app_images.dart';
import 'package:tellesports/widgets/image_view.dart';

import '../../../widgets/modal_content.dart';
import '../../../widgets/modals.dart';

// ignore: must_be_immutable
class PredictionContainer extends StatelessWidget {
  const PredictionContainer({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modals.showDialogModal(context,
                                page: ModalContentScreen(
                                    title: 'Rate this prediction: ',
                                    body: Column(children: [],)
                                        ,
                                    btnText: 'Proceed',
                                    onPressed: () async {


                                      // Navigator.pop(context);
                                      // setState(() {
                                      //   isLoading = true;
                                      // });
                                      // await groupInfo
                                      //     .removeCurrentUserFromBlockedMembers(
                                      //         groupInfo.groupId,
                                      //         widget.userId,
                                      //         context);

                                      // setState(() {
                                      //   isLoading = true;
                                      // });
                                    },
                                    headerColorOne:
                                        Color(0xFFFDF9ED),
                                    headerColorTwo:
                                        Color(0xFFFAF3DA)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 7.h,
          vertical: 14.v,
        ),
        decoration: AppDecoration.outlineTeal.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rated: 4.5/5",
                      style: CustomTextStyles.labelMediumBlack900,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgSignalOrange300,
                      height: 12.adaptSize,
                      width: 12.adaptSize,
                      margin: EdgeInsets.only(left: 2.h),
                    ),
                  ],
                ),
                Text(
                  "14:00-15:30",
                  style: CustomTextStyles.labelMediumBlack900,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 78.v,
                  width: 189.h,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "premier league".toUpperCase(),
                          style: CustomTextStyles.bodySmallBluegray900_1,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.v),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgIdezia,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              SizedBox(height: 2.v),
                              Text(
                                "Liverpool",
                                style: CustomTextStyles.labelLargeBluegray900,
                              ),
                              SizedBox(height: 1.v),
                              Text(
                                "(Home)".toUpperCase(),
                                style: CustomTextStyles.bodySmallBluegray900,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgIdezia24x24,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(
                          top: 14.v,
                          right: 17.h,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 22.v),
                          child: Text(
                            "Aston Villa",
                            style: CustomTextStyles.labelLargeBluegray900,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 14.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 7.v),
                                child: Text(
                                  "3-0",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 38.h,
                                  top: 6.v,
                                  bottom: 7.v,
                                ),
                                child: Text(
                                  "(Away)".toUpperCase(),
                                  style: CustomTextStyles.bodySmallBluegray900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.v),
                ImageView.asset(AppImages.line),
                SizedBox(height: 15.v),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Predicted winner:".toUpperCase(),
                          style: CustomTextStyles.bodySmallOnPrimary,
                        ),
                        SizedBox(height: 1.v),
                        Container(
                        
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.h,
                            vertical: 1.v,
                          ),
                          decoration: AppDecoration.fillTeal100.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                          ),
                          child: Center(
                            child: Text(
                              "Home",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 33.h),
                      child: Column(
                        children: [
                          Text(
                            "Odds:".toUpperCase(),
                            style: CustomTextStyles.bodySmallOnPrimary,
                          ),
                          SizedBox(height: 1.v),
                          Container(
                            width: 45.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.h,
                              vertical: 1.v,
                            ),
                            decoration: AppDecoration.fillTeal100.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder4,
                            ),
                            child: Center(
                              child: Text(
                                "2.88",
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
