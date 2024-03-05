import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart'  as pro;
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/auth/sign_up_screen/sign_up_screen.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../blocs/accounts/account.dart';
import '../../../core/constants/enums.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/firebase_auth_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../../widgets/modals.dart';
import '../../landing_page/landing_page.dart';
import '../../manage_account/verify_account_screen/verify_account_screen.dart';
import '../controller/auth_controller.dart';

// ignore_for_file: must_be_immutable
class SigninScreen extends ConsumerStatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShowPassword1 = false;

  bool isGoogle = false;

  showPassword1() {
    setState(() {
      isShowPassword1 = !isShowPassword1;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final authUser =  pro.Provider.of<FirebaseAuthProvider>(context, listen: true);

    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocProvider<AccountCubit>(
              lazy: false,
              create: (_) => AccountCubit(
                  accountRepository: AccountRepositoryImpl(),
                  viewModel:
                      pro.Provider.of<AccountViewModel>(context, listen: false)),
              child: BlocConsumer<AccountCubit, AccountStates>(
                listener: (context, state) {
                  if (state is AccountUpdated) {
                    if (state.user.success ?? false) {
                      StorageHandler.saveIsLoggedIn('true');
                      StorageHandler.saveUserToken(state.user.token?.token);
                      StorageHandler.saveUserEmail(state.user.user?.email);
                      StorageHandler.saveUserPhone(state.user.user?.phone);
                      StorageHandler.saveUserName(state.user.user?.username);
                      StorageHandler.saveUserPlan(state.user.plan?.name);
                      StorageHandler.saveUserId(state.user.user?.id.toString());
                      StorageHandler.saveUserBalance(
                          state.user.tellacoinBalance.toString());
                      StorageHandler.saveUserPhoto(
                          state.user.profilePicture.toString());
                      StorageHandler.saveUserAccountName(
                          state.user.userWallet?.accountName.toString());
                      StorageHandler.saveUserAccountNumber(
                          state.user.userWallet?.accountNumber.toString());
                      StorageHandler.saveUserBank(
                          state.user.userWallet?.bank.toString());

                      StorageHandler.saveUserPassword(passwordController.text);

                      onTapSignIn(context);
                    } else {
                      if (state.user.error?.isNotEmpty ?? false) {
                        Modals.showToast(state.user.error ?? '');
                        resendCode(context);
                      } else {
                        if (isGoogle) {
                          Modals.showToast(
                              'Please register with google on the registeration page first',
                              messageType: MessageType.error);
                          FirebaseAuth.instance.signOut();
                          final GoogleSignIn googleSignIn = GoogleSignIn();
                          googleSignIn.signOut();
                        } else {
                          if (state.user.message?.isNotEmpty ?? false) {
                            Modals.showToast(state.user.message ?? '',
                                messageType: MessageType.error);
                          } else {
                            Modals.showToast('Failed to login',
                                messageType: MessageType.error);
                          }
                        }
                      }
                    }
                  } else if (state is OTPResent) {
                    if (state.userData.success == true) {
                      Modals.showToast(state.userData.message ?? '',
                          messageType: MessageType.success);
                      AppNavigator.pushAndReplacePage(context,
                          page: VerifyAccountScreen(
                            email: emailController.text,
                            otp: '',
                          ));
                    } else {
                      Modals.showToast(state.userData.message ?? '',
                          messageType: MessageType.success);
                    }
                  } else if (state is AccountApiErr) {
                    if (state.message != null) {
                      Modals.showToast(state.message!,
                          messageType: MessageType.error);
                    }
                  } else if (state is AccountNetworkErr) {
                    if (state.message != null) {
                      Modals.showToast(state.message!,
                          messageType: MessageType.error);
                    }
                  }
                },
                builder: (context, state) => Form(
                    key: _formKey,
                    child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 69.v),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImageView(
                                  imagePath: ImageConstant.imgTellasportLogo,
                                  height: 32.v,
                                  width: 203.h),
                              SizedBox(height: 44.v),
                              Text("Welcome  back!",
                                  style: theme.textTheme.headlineLarge),
                              SizedBox(height: 30.v),
                              _buildEmailOrPhoneSection(context),
                              SizedBox(height: 5.v),
                              _buildPasswordSection(context),
                              SizedBox(height: 8.v),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                            onTap: () {
                                              onTapSignUp(context);
                                            },
                                            child: Text("Sign Up Instead",
                                                style: CustomTextStyles
                                                    .titleSmallBlue400_1
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            Colors.blue,
                                                        fontSize: 15.3)))),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                            onTap: () {
                                              onTapTxtForgotPassword(context);
                                            },
                                            child: Text("Forgot Password?",
                                                style: CustomTextStyles
                                                    .titleSmallBlue400_1
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            Colors.blue,
                                                        fontSize: 15.3)))),
                                  ],
                                ),
                              ),
                              SizedBox(height: 29.v),
                              CustomElevatedButton(
                                  processing: state is AccountLoading,
                                  title: 'Authenticating...',
                                  onPressed: (() =>
                                      loginUser(ctx: context, isGoo: false)),
                                  text: "Login",
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 4.h)),
                              Spacer(),
                              // Text("or login with",
                              //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black38)),
                              SizedBox(height: 11.v),
                              CustomOutlinedButton(
                                text: "Sign in with Google",
                                margin: EdgeInsets.symmetric(horizontal: 4.h),
                                leftIcon: Container(
                                    margin: EdgeInsets.only(right: 10.h),
                                    child: CustomImageView(
                                      imagePath:
                                          ImageConstant.imgSocialMediaIcons,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize,
                                    )),
                                onPressed: () async {
                                  //    await FirebaseAuth.instance.signOut();
                                  // final GoogleSignIn googleSignIn =
                                  //     GoogleSignIn();
                                  // await googleSignIn.signOut();
                                  User? user =
                                      await authUser.signInWithGoogle();
                                  if (user != null) {
                                    loginUser(
                                        ctx: context,
                                        isGoo: true,
                                        email: user.email);
                                  }
                                },
                              ),
                              SizedBox(height: 13.v),
                              if (Platform.isIOS)
                                CustomOutlinedButton(
                                    text: "Sign in with Apple",
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.h),
                                    leftIcon: Container(
                                        margin: EdgeInsets.only(right: 10.h),
                                        child: CustomImageView(
                                            imagePath: ImageConstant
                                                .imgSocialMediaIconsOnprimary,
                                            height: 24.adaptSize,
                                            width: 24.adaptSize)),
                                    onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                      final GoogleSignIn googleSignIn =
                                          GoogleSignIn();
                                      await googleSignIn.signOut();
                                      UserCredential? user =
                                          await authUser.signInWithApple();
                                      if (user != null) {
                                        Modals.showToast(
                                            authUser.successMessage);
                                      } else {
                                        Modals.showToast(
                                            authUser.successMessage);
                                      }
                                    }),
                              SizedBox(height: 10.v)
                            ]))),
              ))),
    ));
  }

  Widget _buildEmailOrPhoneSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("E-mail",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          SizedBox(height: 2.v),
          CustomTextFormField(
              controller: emailController,
              hintText: "Enter your email",
              validator: (value) {
                return Validator.validateEmail(value, 'Email');
              },
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.emailAddress)
        ]));
  }

  Widget _buildPasswordSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Column(crossAxisAlignment: 
      CrossAxisAlignment.start, children: [
        Text("Password",
            style: TextStyle(fontSize: 14, 
            fontWeight: FontWeight.w600)),
        SizedBox(height: 3.v),
        CustomTextFormField(
            controller: passwordController,
            hintText: "Enter Password",
            obscureText: isShowPassword1,
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(30.h, 12.v, 8.h, 12.v),
              child: GestureDetector(
                onTap: () {
                  showPassword1();
                },
                child: isShowPassword1
                    ? Icon(
                        Icons.visibility_off,
                        size: 24,
                      )
                    : Icon(Icons.visibility, size: 24),
              ),
            ),
            suffixConstraints: BoxConstraints(maxHeight: 48.v),
            validator: (value) {
              return Validator.validate(value, 'Password');
            },
            contentPadding: EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
      ]),
    );
  }

  onTapTxtForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
  }

  onTapSignUp(BuildContext context) {
    AppNavigator.pushAndStackPage(context, page: SignUpScreen());
  }

  onTapSignIn(BuildContext context) {
    AppNavigator.pushAndReplacePage(context, page: LandingPage());
  }

  resendCode(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().resendVerifyCode(
            email: emailController.text.trim(),
          );
      FocusScope.of(ctx).unfocus();
    }
  }

  loginUser(
      {required BuildContext ctx, required bool isGoo, String? email}) async {
    if (!isGoo) {
      if (_formKey.currentState!.validate()) {
        await ctx.read<AccountCubit>().loginUser(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        setState(() {
          isGoogle = false;
        });
        FocusScope.of(ctx).unfocus();
      }
    } else {
      await ctx
          .read<AccountCubit>()
          .loginUser(email: email ?? '', password: email ?? '');

      Modals.showToast(email ?? '');

      setState(() {
        isGoogle = true;
      });
      FocusScope.of(ctx).unfocus();
    }
  }


   void storeUserData(String name, userId) async {

    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            null,
            userId
          );
    }
  }
}
