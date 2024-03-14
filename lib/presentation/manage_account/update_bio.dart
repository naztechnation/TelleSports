import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../utils/validator.dart';
import '../community_screens/provider/auth_provider.dart';

class UpdateChatBioScreen extends StatefulWidget {
  UpdateChatBioScreen({Key? key}) : super(key: key);

  @override
  State<UpdateChatBioScreen> createState() => _UpdateChatBioScreenState();
}

class _UpdateChatBioScreenState extends State<UpdateChatBioScreen> {
  TextEditingController bioController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userId = '';

  bool isLoading = false;

  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final user = Provider.of<AuthProviders>(context, listen: true);

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Form(
          key: _formKey,
          child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Update Chat Bio",
                        style: theme.textTheme.headlineLarge),
                    SizedBox(height: 14.v),
                    Text(
                        "This would be used as your bio in  your chat profile.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14, letterSpacing: 0)),
                    SizedBox(height: 29.v),
                    _buildBioField(context),
                    SizedBox(height: 32.v),
                    CustomElevatedButton(
                        text: "Update Bio",
                        title: 'Updating bio...',
                        processing: isLoading,
                        margin: EdgeInsets.symmetric(horizontal: 4.h),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await user.updateUserBio(
                                userId, bioController.text);
                            bioController.clear();
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }),
                    SizedBox(height: 5.v)
                  ]))),
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 389.h,
        leading: AppbarLeadingImage(
            onTap: () {
              Navigator.pop(context);
            },
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(24.h, 20.v, 350.h, 20.v)));
  }

  Widget _buildBioField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Enter Bio", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: bioController,
              hintText: "Enter your bio here",
              hintStyle: CustomTextStyles.titleSmallGray600,
              maxLines: 5,
              textInputType: TextInputType.name,
              validator: (value) {
                return Validator.validate(value, 'Account name');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }
}
