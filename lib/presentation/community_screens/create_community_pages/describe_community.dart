

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/community_screens/community_one_page/create_community_pages/setup_community.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../../common/utils/utils.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../../widgets/image_view.dart';
import '../../provider/auth_provider.dart';

class DescribeCommunity extends ConsumerStatefulWidget {
  DescribeCommunity({Key? key})
      : super(
          key: key,
        );

  @override
  ConsumerState<DescribeCommunity> createState() =>
      _DescribeCommunityState();
}

class _DescribeCommunityState
    extends ConsumerState<DescribeCommunity> {
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
  String fcmToken = '';

  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    fcmToken = await StorageHandler.getUserFCM() ?? '';
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

    final user = pro.Provider.of<AccountViewModel>(context, listen: true);

   
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
            margin: EdgeInsets.only(
              
            ),
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
                    title: "Creating community...",
                    buttonStyle: CustomButtonStyles.fillBlue,
                    processing: isLoading,
                    onPressed: () async {
                      AppNavigator.pushAndStackPage(context,
                                page: SetUpCommunity());
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
        ),
      ],
    );
  }
    

   _showFullImage(BuildContext context, File imageUrl) {
 return  GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.65,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: ImageView.file(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * 0.65,
                            imageUrl,
                            
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top:12.0, right: 20),
                    child: Icon(Icons.close, color: Colors.red, size: 39,),
                  ))
                  ],
                ),
              ],
            ),
          );
  }
}
