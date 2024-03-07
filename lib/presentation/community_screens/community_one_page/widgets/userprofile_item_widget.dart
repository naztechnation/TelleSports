import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

// ignore: must_be_immutable
class UserprofileItemWidget extends StatelessWidget {
  final String name; 
  final String image; 
  final String bio;
  final int index; 
  const UserprofileItemWidget({Key? key, required this.name, required this.bio, required this.index, required this.image})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       if(image != null || image != "null"|| image != "")...[
        CustomImageView(
          imagePath:   ImageConstant.imgAvatar,

          height: 50.adaptSize,
          width: 50.adaptSize,
          radius: BorderRadius.circular(
            18.h,
          ),
          margin: EdgeInsets.symmetric(vertical: 4.v),
        ),
       ]else...[
        CustomImageView(
          imagePath: image,
                                    placeHolder: ImageConstant.imgAvatar,

          height: 50.adaptSize,
          width: 50.adaptSize,
          radius: BorderRadius.circular(
            18.h,
          ),
          margin: EdgeInsets.symmetric(vertical: 4.v),
        ),
       ], 
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
                      name,
                      style: TextStyle(
                        color: appTheme.gray900,
                        fontSize: 14.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      bio,
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
                  padding: EdgeInsets.only(bottom: 0.v),
                  child: Text(
                   (index ==  0) ?  "Community Manager" : "",
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
