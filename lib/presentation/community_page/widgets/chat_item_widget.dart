import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

// ignore: must_be_immutable
class ChatItemWidget extends StatelessWidget {
  ChatItemWidget({
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
            Container(
              margin: EdgeInsets.only(left: 10.h),
              padding: EdgeInsets.only(
                top: 9.v,
                bottom: 8.v,
              ),
              decoration: AppDecoration.outlineGray600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pixsellz Team",
                    style: CustomTextStyles.titleMediumBlack900_1,
                  ),
                  SizedBox(height: 2.v),
                  Text(
                    "1,223 members",
                    style: CustomTextStyles.titleSmallBluegray400,
                  ),
                  SizedBox(height: 12.v),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
