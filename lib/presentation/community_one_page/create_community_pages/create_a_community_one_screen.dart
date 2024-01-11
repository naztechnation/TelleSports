import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_title.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../widgets/app_bar/appbar_subtitle.dart';
import 'create_a_community_screen.dart';

class CreateACommunityOneScreen extends StatelessWidget {
  CreateACommunityOneScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 40.v,
              ),
              child: Column(
                children: [
                  Container(
                    height: 100.adaptSize,
                    width: 100.adaptSize,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 19.v,
                    ),
                    // decoration: AppDecoration.outlineBlue200.copyWith(
                    //   borderRadius: BorderRadiusStyle.circleBorder50,
                    // ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgLock,
                      height: 59.v,
                      width: 65.h,
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(height: 10.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add community photo",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontSize: 14.fSize,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgEdit,
                        height: 16.adaptSize,
                        width: 16.adaptSize,
                        margin: EdgeInsets.only(
                          left: 2.h,
                          bottom: 2.v,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 23.v),
                  _buildTextField(context),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                    text: "Save and continue",
                    buttonStyle: CustomButtonStyles.fillBlue,
                    onPressed: () {
                      
                      AppNavigator.pushAndStackPage(context, page: CreateACommunityScreen());
                    },
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
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
        text: "Create a community",
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
      
    );
  }
 
  Widget _buildTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Community name",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.v),
        CustomTextFormField(
          controller: nameController,
          hintText: "Name your community",
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
