import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

// ignore: must_be_immutable
class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgDisplayPicture,
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
                      style: TextStyle(
                        color: appTheme.gray900,
                        fontSize: 14.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "This is my bio",
                      style: TextStyle(
                        color: appTheme.gray600,
                        fontSize: 12.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 22.v),
                  child: Text(
                    "Community manager",
                    style: TextStyle(
                      color: appTheme.gray900,
                      fontSize: 10.fSize,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
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