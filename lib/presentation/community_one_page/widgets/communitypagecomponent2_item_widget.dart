import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

// ignore: must_be_immutable
class Communitypagecomponent2ItemWidget extends StatelessWidget {
  Communitypagecomponent2ItemWidget({
    Key? key,
    this.onTapCommunityPageComponent,
  }) : super(
          key: key,
        );

  VoidCallback? onTapCommunityPageComponent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          onTapCommunityPageComponent!.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgDisplayPicture60x60,
              height: 60.adaptSize,
              width: 60.adaptSize,
              radius: BorderRadius.circular(
                30.h,
              ),
              margin: EdgeInsets.symmetric(vertical: 7.v),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.h),
                padding: EdgeInsets.only(
                  top: 6.v,
                  bottom: 5.v,
                ),
                decoration: AppDecoration.outlineGray,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pixsellz Team",
                          style: CustomTextStyles.titleMediumOnPrimary_1,
                        ),
                        SizedBox(height: 1.v),
                        Text(
                          "Hasan Web",
                          style: theme.textTheme.titleSmall,
                        ),
                        SizedBox(height: 1.v),
                        Text(
                          "GIF",
                          style: CustomTextStyles.titleSmallGray600,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.v,
                        bottom: 6.v,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "12:23",
                            style: CustomTextStyles.titleSmallGray600,
                          ),
                          SizedBox(height: 9.v),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 24.adaptSize,
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 5.v,
                              ),
                              decoration: AppDecoration.fillBlue.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder12,
                              ),
                              child: Text(
                                "99+",
                                style: CustomTextStyles.labelMediumWhiteA700,
                              ),
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
      ),
    );
  }
}
