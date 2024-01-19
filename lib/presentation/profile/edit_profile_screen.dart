import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../model/view_models/user_view_model.dart';
import '../../widgets/image_view.dart';

class EditProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String phone;
  
  EditProfileScreen({Key? key, required this.username, required this.email, required this.phone})
      : super(
          key: key,
        );

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

        final user = Provider.of<UserViewModel>(context, listen: true);


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 24.v,
              ),
              child: Column(
                children: [
                 
                   if (user.imageURl == null) ...[
                      GestureDetector(
                        onTap: () {
                          user.loadImage(
                             context,
                          );
                        },
                        child: CustomImageView(
                    imagePath: ImageConstant.imgNavIcons,
                    height: 100.adaptSize,
                    width: 100.adaptSize,
                    radius: BorderRadius.circular(
                      50.h,
                    ),
                  ),
                      ),
                    ] else ...[
                      GestureDetector(
                        onTap: () {
                          user.loadImage(
                             context,
                          );
                        },
                        child: Container(
                            width: 140,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: ImageView.file(
                                  File(
                                    user.imageURl!.path,
                                  ),
                                  fit: BoxFit.cover),
                            )),
                      ),
                    ],
                  SizedBox(height: 10.v),
                  GestureDetector(
                    onTap: () {
                          user.loadImage(
                             context,
                          );
                        },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Edit picture",
                          style: CustomTextStyles.titleSmallBluegray900,
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
                  ),
                  SizedBox(height: 21.v),
                  _buildTextField1(context),
                  SizedBox(height: 23.v),
                  _buildTextField2(context),
                  SizedBox(height: 23.v),
                  _buildTextField3(context),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                    text: "Save changes",
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
       // bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

   
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 93.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 59.v,
          bottom: 10.v,
        ),
        onTap: (){
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitleOne(
        text: "Edit profile",
        margin: EdgeInsets.only(
          top: 60.v,
          bottom: 8.v,
        ),
      ),
      styleType: Style.bgOutline_4,
    );
  }

   
  Widget _buildTextField1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Username",
          style: CustomTextStyles.titleSmallBlack900,
        ),
        SizedBox(height: 3.v),
        CustomTextFormField(
          controller: userNameController,
          hintText: "@${username}",
          hintStyle: CustomTextStyles.titleSmallGray600,
        ),
      ],
    );
  }

   
  Widget _buildTextField2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: CustomTextStyles.titleSmallBlack900,
        ),
        SizedBox(height: 3.v),
        CustomTextFormField(
          controller: emailController,
          hintText: email,
          hintStyle: CustomTextStyles.titleSmallGray600,
          textInputType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildTextField3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone number",
          style: CustomTextStyles.titleSmallBlack900,
        ),
        SizedBox(height: 3.v),
        CustomTextFormField(
          controller: phoneNumberController,
          hintText: phone,
          hintStyle: CustomTextStyles.titleSmallGray600,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.phone,
        ),
      ],
    );
  }

   
  }
