import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../individual_user_info.dart/individual_user_info.dart';

// ignore: must_be_immutable
class Userprofile1ItemWidget extends StatelessWidget {
  const Userprofile1ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgDisplayPicture36x36,
          height: 36.adaptSize,
          width: 36.adaptSize,
          radius: BorderRadius.circular(
            18.h,
          ),
          margin: EdgeInsets.symmetric(vertical: 4.v),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10.h),
            padding: EdgeInsets.only(
              top: 3.v,
              bottom: 2.v,
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
                      "Joshua11",
                      style: theme.textTheme.titleSmall,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "This is my bio",
                      style: CustomTextStyles.labelLargeGray600,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 22.v),
                  child: Text(
                    "Community manager",
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
