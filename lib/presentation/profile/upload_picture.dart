import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/loading_page.dart';

import '../../blocs/accounts/account.dart';
import '../../core/constants/enums.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../widgets/image_view.dart';
import '../../widgets/modals.dart';

class UpdateProfileImageScreen extends StatelessWidget {
  UpdateProfileImageScreen({
    Key? key,
  }) : super(
          key: key,
        );

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
          if (state is AccountLoaded) {
            if (state.userData.success == true) {
               Modals.showToast( 'image upload successful',
                  messageType: MessageType.success);
            } else {
              Modals.showToast(state.userData.message ?? '',
                  messageType: MessageType.error);
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
        builder: (context, state) => (state is AccountProcessing) ? LoadingPage(): Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(context, user),
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: user.imageURl == null ?20.h :0,
                vertical: user.imageURl == null ?24.h :0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (user.imageURl == null) ...[
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.2,
                    ),
                    GestureDetector(
                      onTap: () {
                        user.loadImage(
                          context,
                        );
                      },
                      child: CustomImageView(
                        imagePath: ImageConstant.imgNavIcons,
                        height: 200.adaptSize,
                        width: 200.adaptSize,
                        radius: BorderRadius.circular(
                          50.h,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      alignment: Alignment.center,
                      child: GestureDetector(
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
                              style: CustomTextStyles.titleMediumBlack900Bold,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgEdit,
                              height: 19.adaptSize,
                              width: 19.adaptSize,
                              margin: EdgeInsets.only(
                                left: 2.h,
                                bottom: 2.v,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            user.loadImage(
                              context,
                            );
                          },
                          child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.85,
                              child: ImageView.file(
                                  File(
                                    user.imageURl!.path,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 40,
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.white60,
                            child: GestureDetector(
                              onTap: () {
                                user.loadImage(
                                  context,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Change picture",
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
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 24.v),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, user) {
    return CustomAppBar(
      height: 70.v,
      leadingWidth: 100.h,
      leading: GestureDetector(
        onTap: (() {
          Navigator.pop(context);
        }),
        child: Padding(
           padding: EdgeInsets.only(
                    left: 20.h,
                     top: 20.v,
                    bottom: 10.v,
                  ),
          child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
        ),
      ),
      centerTitle: true,
      title: (user.imageURl == null)
          ? AppbarSubtitleOne(
              text: "Upload Picture",
              margin: EdgeInsets.only(
                //  top: 10.v,
                bottom: 8.v,
              ),
            )
          : SizedBox.shrink(),
      styleType: Style.bgOutline_4,
      actions: [
        if (user.imageURl != null)
          GestureDetector(
              onTap: (() {
                updateProfilePicture(context, user.imageURl!);
              }),
              child: Padding(
                padding: EdgeInsets.only(
                  right: 20.h,
                  bottom: 10.v,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ))
      ],
    );
  }

  updateProfilePicture(BuildContext ctx, File imageUrl) {
    ctx.read<AccountCubit>().uploadUserProfileImage(
          image: imageUrl,
        );
    FocusScope.of(ctx).unfocus();
  }
}
