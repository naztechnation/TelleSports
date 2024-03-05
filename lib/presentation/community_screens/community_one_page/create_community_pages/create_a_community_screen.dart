import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../../widgets/app_bar/appbar_subtitle.dart';
 

class CreateACommunityScreen extends StatelessWidget {
  CreateACommunityScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController placeholderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 40.v,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 323.h,
                  margin: EdgeInsets.only(right: 26.h),
                  child: Text(
                    "A community description will help other users understand what your community is really about.",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.fSize,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 21.v),
              CustomTextFormField(
                controller: placeholderController,
                hintText: "Describe your community",
                textInputAction: TextInputAction.done,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 11.v,
                ),
              ),
              SizedBox(height: 3.v),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "0/300 characters",
                  style: TextStyle(
                    fontSize: 14.fSize,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 23.v),
              CustomElevatedButton(
                text: "Save and continue",
                buttonStyle: CustomButtonStyles.fillBlue,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: (){
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Describe your community",
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
      
    );;
  }
}
