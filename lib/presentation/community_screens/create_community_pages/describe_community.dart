
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/community_screens/create_community_pages/setup_community.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
 

class DescribeCommunity extends ConsumerStatefulWidget {
  final String communityName;
  final File communityImage;

  DescribeCommunity({Key? key,required this.communityName, required this.communityImage, })
      : super(
          key: key,
        );

  @override
  ConsumerState<DescribeCommunity> createState() => _DescribeCommunityState();
}

class _DescribeCommunityState extends ConsumerState<DescribeCommunity> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupDescriptionController =
      TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    groupDescriptionController.dispose();

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingImage(
            onTap: () {
              Navigator.pop(context);
            },
            imagePath: ImageConstant.imgArrowBack,
            margin: EdgeInsets.only(
              left: 20.h,
            ),
          ),
          centerTitle: true,
          title: AppbarSubtitle(
            text: "Describe your community",
            margin: EdgeInsets.only(),
          ),
        ),
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
                  _buildTextField(context),
                  SizedBox(height: 40.v),
                  CustomElevatedButton(
                    text: "Save and continue",
                     
                    buttonStyle: CustomButtonStyles.fillBlue,
                    onPressed: () async {

                      if (_formKey.currentState!.validate()) {
                      AppNavigator.pushAndStackPage(context,
                          page: SetUpCommunity(
                            communityName: widget.communityName,
                            communityDesc: groupDescriptionController.text, communityImage: widget.communityImage,
                          ));
                    }
                    }
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

  Widget _buildTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "A community description will help other users understand what your community is really about.",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 40.v),
        CustomTextFormField(
          controller: groupDescriptionController,
          hintText: "Describe your community",
          maxLines: 4,
          textInputAction: TextInputAction.done,
          validator: (value) {
            return Validator.validate(value, 'Community description');
          },
        ),
      ],
    );
  }

  
}
