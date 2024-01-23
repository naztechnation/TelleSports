import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/model/auth_model/login.dart';
import 'package:tellesports/utils/validator.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../blocs/accounts/account.dart';
import '../../core/constants/enums.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../widgets/image_view.dart';
import '../../widgets/modals.dart';
import '../auth/signin_screen/sign_in_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String phone;

  EditProfileScreen(
      {Key? key,
      required this.username,
      required this.email,
      required this.phone})
      : super(
          key: key,
        );

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String profileImage = '';

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final user = Provider.of<UserViewModel>(context, listen: true);

    return SafeArea(
        child: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is AccountUpdated) {
            if (state.user.success ?? false) {
              Modals.showToast(state.user.message ?? '');

              AppNavigator.pushAndReplacePage(context, page: SigninScreen());
            } else {
              Modals.showToast(state.user.message ?? '');
            }
          } else if (state is AccountApiErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          } else if (state is AccountNetworkErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          }
        },
        builder: (context, state) => Scaffold(
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
                      title: 'Updating Profile...',
                      processing:
                          state is AccountLoading ,
                      text: "Save changes",
                      onPressed: () {
                        if (user.imageURl == null) {
                          Modals.showToast('Please select an image to update');
                        } else {
                          if (_formKey.currentState!.validate()) {
                                                         updateUserProfile(context, user.imageURl!);

                          }
                        }
                      },
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
          // bottomNavigationBar: _buildBottomBar(context),
        ),
      ),
    ));
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
        onTap: () {
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
          readOnly: true,
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
          readOnly: true,
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
          validator: (value) {
            return Validator.validate(value, 'Phone Number');
          },
          suffix: Padding(
            padding: const EdgeInsets.all(13.0),
            child: CustomImageView(
              imagePath: ImageConstant.imgEdit,
              height: 13.adaptSize,
              width: 13.adaptSize,
              margin: EdgeInsets.only(
                left: 2.h,
                bottom: 2.v,
              ),
            ),
          ),
        ),
      ],
    );
  }

  updateProfilePicture(BuildContext ctx, File imageUrl) {
    ctx.read<AccountCubit>().uploadUserProfileImage(
          image: imageUrl,
        );
    FocusScope.of(ctx).unfocus();
  }

  updateUserProfile(BuildContext ctx, File imageUrl) {
    ctx.read<AccountCubit>().uploadUserProfile(
        image: imageUrl, phone: phoneNumberController.text.trim());
    FocusScope.of(ctx).unfocus();
  }
}
