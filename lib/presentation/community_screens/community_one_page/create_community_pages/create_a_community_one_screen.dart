import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../../../common/utils/utils.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../../widgets/app_bar/appbar_subtitle.dart';
import '../../group/controller/group_controller.dart';
import '../../group/widgets/select_contacts_group.dart';
import '../../provider/auth_provider.dart';
import 'create_a_community_screen.dart';

class CreateACommunityOneScreen extends ConsumerStatefulWidget {
  CreateACommunityOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  ConsumerState<CreateACommunityOneScreen> createState() =>
      _CreateACommunityOneScreenState();
}

class _CreateACommunityOneScreenState
    extends ConsumerState<CreateACommunityOneScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupDescriptionController =
      TextEditingController();

  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  bool isLoading = false;

  String userId = '';

  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
    groupDescriptionController.dispose();
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupData = pro.Provider.of<AuthProviders>(context, listen: true);

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
                  image == null
                      ? Container(
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
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            image!,
                          ),
                          radius: 64,
                        ),
                  SizedBox(height: 10.v),
                  GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: Row(
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
                  ),
                  SizedBox(height: 23.v),
                  _buildTextField(context),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                    text: "Save and continue",
                    buttonStyle: CustomButtonStyles.fillBlue,
                    processing: isLoading,
                    onPressed: () async {
                      if (groupNameController.text.trim().isNotEmpty &&
                          groupDescriptionController.text.trim().isNotEmpty &&
                          image != null) {
                        setState(() {
                          isLoading = true;
                        });

                        var isTrue = await groupData.checkUserGroupLimit(
                            userId: userId,
                            context: context,
                            name: groupNameController.text.trim(),
                            groupDesc: groupDescriptionController.text.trim(),
                            profilePic: image!,
                            ref: ref);
                        setState(() {
                          isLoading = false;
                        });

                        if (isTrue) {
                          AppNavigator.pushAndStackPage(context,
                              page: LandingPage());
                        } else {
                          Modals.showToast('Failed  to create group');
                        }
                      } else {
                        Modals.showToast(
                            'Please input all fields and an image');
                      }
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
        onTap: () {
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
          controller: groupNameController,
          hintText: "Name your community",
          textInputAction: TextInputAction.next,
        ),
        Text(
          "Enter description",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.v),
        CustomTextFormField(
          controller: groupDescriptionController,
          hintText: "Commuity description",
          maxLines: 4,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
