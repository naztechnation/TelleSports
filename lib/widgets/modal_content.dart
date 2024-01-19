import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';

class ModalContentScreen extends StatelessWidget {
  final String title;
  final String body;
  final String btnText;
  final Color headerColorOne;
  final Color headerColorTwo;
  final Function()? onPressed;


  const ModalContentScreen({Key? key, required this.title, required this.body, required this.btnText, required this.headerColorOne, required this.headerColorTwo,  this.onPressed})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeaderFrame(context, title, headerColorOne, headerColorTwo),
            SizedBox(height: 10.v),
            Container(
              width: 350.h,
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                body,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 14.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20.v),
            CustomOutlinedButton(
              text: btnText,
              onPressed: (onPressed == null) ? () => Navigator.pop(context) : onPressed,

              margin: EdgeInsets.symmetric(horizontal: 20.h),
            ),
            SizedBox(height: 25.v),
          ],
        ));
      
  }

  Widget _buildHeaderFrame(BuildContext context, String title, Color colorOne,Color colorTwo ) {
    return Container(
      height: 53.v,
      width: double.maxFinite,
      decoration: BoxDecoration(color: colorOne),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          
          CustomImageView(
            imagePath: ImageConstant.imgEllipse7,
            height: 37.v,
            width: 313.h,
            alignment: Alignment.bottomRight,
      color: colorTwo,

          ),
          CustomImageView(
            imagePath: ImageConstant.imgEllipse8,
            height: 40.v,
            width: 288.h,
            alignment: Alignment.topLeft,
      color: colorTwo,

          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.fSize,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
