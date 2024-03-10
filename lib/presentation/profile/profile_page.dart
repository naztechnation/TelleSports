import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/core/constants/enums.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/auth/sign_in_screen/sign_in_screen.dart';
import 'package:tellesports/presentation/manage_account/update_account.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../blocs/accounts/account.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/firebase_auth_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/modal_content.dart';
import '../chats_settings_screen/chats_settings_screen.dart';
import '../live_chat/live_chat.dart';
import '../manage_account/create_new_password_screen/create_new_password_screen.dart';
import '../manage_account/update_bio.dart';
import '../notification_settings_screen/notification_settings_screen.dart';
import 'edit_profile_screen.dart';
import 'upload_picture.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String email = '';
  String phone = '';
  String photo = '';
  String userId = '';
   bool showDelayedWidget = false;

  getUserData() async {
    username = await StorageHandler.getUserName() ?? '';
    email = await StorageHandler.getUserEmail() ?? '';
    phone = await StorageHandler.getUserPhone() ?? '';
    photo = await StorageHandler.getUserPhoto() ?? '';
    userId = await StorageHandler.getUserId() ?? '';

    setState(() {});
  }

  @override
  void initState() {
    getUserData();
     Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showDelayedWidget = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final user = Provider.of<FirebaseAuthProvider>(context, listen: true);

    return SafeArea(
        child: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is DeletingUserLoaded) {
            if (state.userData.success == true) {
               Modals.showToast( 'image upload successful',
                  messageType: MessageType.success);
                  AppNavigator.pushAndReplacePage(context, page: SigninScreen());
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
        builder: (context, state) => Scaffold(
              appBar: _buildAppBar(context),
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 24.v),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      _buildAvatarFrame(context),
                      // SizedBox(height: 24.v),
                      // _buildSettingsFrame(context),
                      SizedBox(height: 24.v),
                      _buildShareFrame(context,
                          text: "Contact Support",
                          image: ImageConstant.imgHelpCenter, onTap: () {
                        AppNavigator.pushAndStackPage(context,
                            page: LiveChat(
                              username: username,
                              email: email,
                            ));
                      }),
                      SizedBox(height: 24.v),
                      _buildShareFrame(context,
                          text: "Change Password",
                          image: ImageConstant.imgHelpCenter, onTap: () {
                        AppNavigator.pushAndStackPage(context,
                            page: CreateNewPasswordScreen());
                      }),
                       SizedBox(height: 24.v),
                      _buildShareFrame(context,
                          text: "Update Account",
                          image: ImageConstant.imgHelpCenter, onTap: () {
                        AppNavigator.pushAndStackPage(context,
                            page: UpdateAccountScreen());
                      }),
                      SizedBox(height: 24.v),

                       _buildShareFrame(context,
                          text: "Update Bio",
                          image: ImageConstant.imgHelpCenter, onTap: () {
                        AppNavigator.pushAndStackPage(context,
                            page: UpdateChatBioScreen());
                      }),
                      SizedBox(height: 24.v),
                      _buildShareFrame(context,
                          text: "Share Tellasport",
                          image: ImageConstant.imgShareGray700, onTap: () async {
                        final result = await Share.shareWithResult(
                            'check out our mobile app on app store: , and play store:');
          
                        if (result.status == ShareResultStatus.success) {
                          Modals.showToast('Thank you for sharing our platform',
                              messageType: MessageType.success);
                        }
                      }),
                      SizedBox(height: 24.v),
                    if(state is DeletingUserLoading)...[

                    ]else...[
                       CustomElevatedButton(
                          text: "Log out",
                          buttonStyle: CustomButtonStyles.fillRedTL8,
                          onPressed: () {
                            user.signOut(context);
                          }),
                    ] ,
                      SizedBox(height: 24.v),
                      CustomOutlinedButton(
                          text: "Delete your account",
                          processing: state is DeletingUserLoading,
                          title: 'Deleting account...',
                          buttonTextStyle: TextStyle(color: Colors.red, fontSize: 15),
                          buttonStyle: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            
                            side: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            Modals.showDialogModal(context,
                                page: ModalContentScreen(
                                    title: 'Delete your Account!!!',
                                    body:
                                        'N.B: Are you sure you want to delete your account. This action can\'t be reversed.',
                                    btnText: 'Delete',
                                    
                                    onPressed: () {
                                      deleteUserAccount(context);
                                      Navigator.pop(context);
                                    },
                                    headerColorOne:
                                        Color.fromARGB(255, 208, 151, 151),
                                    headerColorTwo:
                                        Color.fromARGB(255, 234, 132, 132)));
                          }),
                    ]),
                  ))),
        )));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 80.v,
        centerTitle: true,
        title: AppbarSubtitleOne(
         
            text: "Settings", margin: EdgeInsets.only(top: 20.v, bottom: 1.v)),
        styleType: Style.bgOutline_4);
  }

  Widget _buildAvatarFrame(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapAvatarFrame(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
       if(photo == 'null')...[
          CustomImageView(
              imagePath: ImageConstant.imgNavProfilePrimary,
              height: 64.adaptSize,
              width: 64.adaptSize,
              radius: BorderRadius.circular(32.h)),
       ]else...[
      if(showDelayedWidget)...[
        CustomImageView(
              imagePath: photo,
              height: 64.adaptSize,
              width: 64.adaptSize,
              radius: BorderRadius.circular(32.h)),
      ]else...[
        SizedBox(
          height: 14,
          width: 14,
          child: CircularProgressIndicator(
          strokeWidth: 3.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          backgroundColor: (Colors.grey)),
        )
      ]  
       ],   
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 10.h, top: 11.v, bottom: 11.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(username,
                          style: CustomTextStyles.titleMediumOnPrimaryBold18),
                      SizedBox(height: 3.v),
                      Text(email, 
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.black))
                    ])),
          ),
          // Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRightGray700,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.symmetric(vertical: 20.v))
        ]));
  }

  Widget _buildSettingsFrame(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.v),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _buildChatSettingsFrame(context, text: "Notifications settings",
              onPressed: () {
            AppNavigator.pushAndStackPage(context,
                page: NotificationSettingsScreen());
          }),
          SizedBox(height: 12.v),
          Divider(color: appTheme.gray50001),
          SizedBox(height: 11.v),
          _buildChatSettingsFrame(context, text: "Chat settings",
              onPressed: () {
            AppNavigator.pushAndStackPage(context, page: ChatsSettingsScreen());
          })
        ]));
  }

  Widget _buildChatSettingsFrame(
    BuildContext context, {
    required String text,
    required Function onPressed,
  }) {
    return GestureDetector(
      onTap: (() {
        onPressed();
      }),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
            padding: EdgeInsets.only(top: 4.v),
            child: Text(text,
                style: theme.textTheme.titleSmall!
                    .copyWith(color: theme.colorScheme.onPrimary))),
        CustomImageView(
            imagePath: ImageConstant.imgArrowRightGray700,
            height: 24.adaptSize,
            width: 24.adaptSize)
      ]),
    );
  }

  Widget _buildShareFrame(
    BuildContext context, {
    required String text,
    required String image,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () async {
        onTap();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.v),
          decoration: AppDecoration.outlineBlack9001
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.only(top: 4.v, bottom: 1.v),
                child: Text(text,
                    style: TextStyle(fontSize: 14, color: Colors.black))),
            CustomImageView(
                imagePath: image, height: 24.adaptSize, width: 24.adaptSize)
          ])),
    );
  }

  onTapAvatarFrame(BuildContext context) {
    if (photo == 'null') {
      AppNavigator.pushAndStackPage(context, page: UpdateProfileImageScreen());
    } else {
      AppNavigator.pushAndStackPage(context,
          page: EditProfileScreen(
            username: username,
            email: email,
            phone: phone,
          ));
    }
  }

   deleteUserAccount(BuildContext ctx, ) {
    ctx.read<AccountCubit>().deleteUserProfile(
          userId: userId,
        );
    FocusScope.of(ctx).unfocus();
  }
}
