import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/manage_account/verify_account_screen/verify_account_screen.dart';
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
import '../signin_screen/sign_in_screen.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController userNameGoogleController = TextEditingController();

  TextEditingController phoneNumberGoogleController = TextEditingController();

  String googleEmail = '';
  

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShowPassword1 = false;
  bool isGoogles = false;

  showPassword1() {
    setState(() {
      isShowPassword1 = !isShowPassword1;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final authUser = Provider.of<FirebaseAuthProvider>(context, listen: true);

    return SafeArea(
        child: GestureDetector(
           onTap: () {
      FocusScope.of(context).unfocus();
            
          },
          child: Scaffold(
            body: Scaffold(
                resizeToAvoidBottomInset: false,
                body: BlocProvider<AccountCubit>(
                    lazy: false,
                    create: (_) => AccountCubit(
                        accountRepository: AccountRepositoryImpl(),
                        viewModel:
                            Provider.of<AccountViewModel>(context, listen: false)),
                    child: BlocConsumer<AccountCubit, AccountStates>(
                      listener: (context, state) {
                        if (state is AccountLoaded) {
                          if (state.userData.success!) {
                            if (isGoogles) {
                          
                              loginUser(context);
                            } else {
                              onTapRegister(context);
                              Modals.showToast(state.userData.message ?? '',
                                  messageType: MessageType.success);
                            }
                          } else {
            
                            if (state.userData.errors != null) {
                              if (state.userData.errors?.email?.isNotEmpty ??
                                  false) {
                                Modals.showToast(
                                    state.userData.errors?.email?[0] ?? '');
                              } else if (state
                                      .userData.errors?.username?.isNotEmpty ??
                                  false) {
                                Modals.showToast(
                                    state.userData.errors?.username?[0] ?? '');
                              } else if (state.userData.errors?.phone?.isNotEmpty ??
                                  false) {
                                Modals.showToast(
                                    state.userData.errors?.phone?[0] ?? '');
                              } else {
                                Modals.showToast(state.userData.message ?? '');
                              }
                            }
                          }
                        } else if (state is AccountUpdated) {
                          if (state.user.success ?? false) {
                            StorageHandler.saveIsLoggedIn('true');
                            StorageHandler.saveUserToken(state.user.token?.token);
                            StorageHandler.saveUserEmail(state.user.user?.email);
                            StorageHandler.saveUserPhone(state.user.user?.phone);
                            StorageHandler.saveUserName(state.user.user?.username);
                            StorageHandler.saveUserPlan(state.user.plan?.name);
                            StorageHandler.saveUserId(
                                state.user.user?.id.toString());
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
            
                            StorageHandler.saveUserPassword(
                                passwordController.text);
            
                            onTapSignIn(context);
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
                      builder: (context, state) => SingleChildScrollView(
                        child: Form(
                            key: _formKey,
                            child: Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.h, vertical: 45.v),
                                child: Column(children: [
                                  SizedBox(height: 23.v),
                                  CustomImageView(
                                      imagePath: ImageConstant.imgTellasportLogo,
                                      height: 32.v,
                                      width: 203.h),
                                  SizedBox(height: 32.v),
                                  Text("Register",
                                      style: theme.textTheme.headlineLarge),
                                  SizedBox(height: 13.v),
                                  _buildUsernameTextField(context),
                                  SizedBox(height: 10.v),
                                  _buildEmailTextField(context),
                                  SizedBox(height: 10.v),
                                  _buildPhoneNumberTextField(context),
                                  SizedBox(height: 10.v),
                                  _buildPasswordTextField(context),
                                  SizedBox(height: 24.v),
                                  CustomElevatedButton(
                                      text: "Register",
                                      processing: (state is AccountProcessing ||
                                          authUser.status ||
                                          state is AccountLoading),
                                      margin: EdgeInsets.symmetric(horizontal: 4.h),
                                      title: 'Creating Account...',
                                      onPressed: () {
                                        registerUser(
                                            context: context, isGoogle: false);
                                        // onTapRegister(context);
                                      }),
                                  SizedBox(height: 9.v),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Already have an account? ",
                                          style: CustomTextStyles
                                              .titleSmallBluegray900_1,
                                        ),
                                        TextSpan(
                                          text: "Sign in",
                                          style: CustomTextStyles.titleSmallPrimary,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              onTapLogin(context);
                                            },
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 42.v),
                                  CustomOutlinedButton(
                                    text: "Sign in with Google",
                                    processing: (state is AccountProcessing ||
                                        authUser.status ||
                                        state is AccountLoading),
                                    title: 'Verfying account...',
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
                                       await FirebaseAuth.instance.signOut();
                                        final GoogleSignIn googleSignIn =
                                            GoogleSignIn();
                                        await googleSignIn.signOut();
                                      Modals.showBottomSheetModal(
                                        context,
                                        isDissmissible: true,
                                        heightFactor: 0.9,
                                        page: registerUserWithGoogle(
                                            authUser, context),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 13.v),
                                 if (Platform.isIOS) 
                                  CustomOutlinedButton(
                                      text: "Sign in with Apple",
                                      margin: EdgeInsets.symmetric(horizontal: 4.h),
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
                                          Modals.showToast(authUser.successMessage);
                                        } else {
                                          Modals.showToast(authUser.successMessage);
                                        }
                                      }),
                                  SizedBox(height: 13.v),
                                  Container(
                                      width: 342.h,
                                      margin: EdgeInsets.symmetric(horizontal: 7.h),
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "By ",
                                                style: CustomTextStyles
                                                    .titleSmallBluegray900_1),
                                            TextSpan(
                                                text: "signing up",
                                                style: CustomTextStyles
                                                    .titleSmallBluegray900_1),
                                            TextSpan(
                                                text: ", you agree to ",
                                                style: CustomTextStyles
                                                    .titleSmallBluegray900_1),
                                            TextSpan(
                                                text: "our",
                                                style: CustomTextStyles
                                                    .titleSmallBluegray900_1),
                                            TextSpan(text: " "),
                                            TextSpan(
                                                text: "Terms of Service",
                                                style: CustomTextStyles
                                                    .titleSmallBlue400),
                                            TextSpan(
                                                text: " and ",
                                                style: CustomTextStyles
                                                    .titleSmallBluegray900_1),
                                            TextSpan(
                                                text: "Privacy Policy",
                                                style: CustomTextStyles
                                                    .titleSmallBlue400),
                                            TextSpan(
                                                text: ".",
                                                style: CustomTextStyles
                                                    .titleSmallBluegray900_1)
                                          ]),
                                          textAlign: TextAlign.center))
                                ]))),
                      ),
                    ))),
          ),
        ));
  }

  Widget _buildUsernameTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Username", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
            controller: userNameController,
            hintText: "Create a username",
            hintStyle: CustomTextStyles.titleSmallGray600,
            validator: (value) {
              return Validator.validate(value, 'Username');
            },
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
          )
        ]));
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("E-mail ", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
            controller: emailController,
            hintText: "Enter your email",
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              return Validator.validateEmail(value, 'Email');
            },
          )
        ]));
  }

  Widget _buildPhoneNumberTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Phone number", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
            controller: phoneNumberController,
            hintText: "Enter your phone number",
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputType: TextInputType.phone,
            validator: (value) {
              return Validator.validate(value, 'Contact');
            },
          )
        ]));
  }

  Widget _buildPhoneNumberGoogleTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Phone number", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
            controller: phoneNumberGoogleController,
            hintText: "Enter your phone number",
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            validator: (value) {
              return Validator.validate(value, 'Contact');
            },
          )
        ]));
  }

  Widget _buildUserNameGoogleTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Username", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
            controller: userNameGoogleController,
            hintText: "Enter username",
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputType: TextInputType.name,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            validator: (value) {
              return Validator.validate(value, 'Username');
            },
          )
        ]));
  }

  Widget _buildPasswordTextField(
    BuildContext context,
  ) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Create a password", style: theme.textTheme.titleSmall),
          SizedBox(height: 2.v),
          CustomTextFormField(
            controller: passwordController,
            hintText: "Enter your password",
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputAction: TextInputAction.done,
            obscureText: isShowPassword1,
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
            contentPadding: EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v),
            validator: (value) {
              return Validator.validate(value, 'Password');
            },
          )
        ]));
  }

  onTapRegister(BuildContext context) {
    AppNavigator.pushAndStackPage(context,
        page: VerifyAccountScreen(
          email: emailController.text.trim(),
        ));
  }

  onTapLogin(BuildContext context) {
    AppNavigator.pushAndStackPage(context, page: SigninScreen());
  }

  registerUser({
    required BuildContext context,
    required bool isGoogle,
    String? email,
    String? password,
    String? phoneNumber,
    String? username,
  }) async {
    if (!isGoogle) {
      setState(() {
        isGoogles = false;
      });
      if (_formKey.currentState!.validate()) {
        context.read<AccountCubit>().registerUser(
            username: userNameController.text.trim(),
            confirmPassword: passwordController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            phoneNumber: phoneNumberController.text.trim(), activated: 'false');
      }
    } else {
      setState(() {
        isGoogles = true;
          googleEmail = email ?? '';

      });


      await context.read<AccountCubit>().registerUser(
          username: username ?? '',
          confirmPassword: password ?? '',
          email: email ?? '',
          password: password ?? '',
          phoneNumber: phoneNumber ?? '',
          activated: 'true'
          );


      phoneNumberGoogleController.clear();
      userNameGoogleController.clear();
    }
  }

  registerUserWithGoogle(var authUser, BuildContext ctxt) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.green,
                    ))
              ],
            ),
            SizedBox(height: 24.v),
            Text("Please enter the following details to continue",
                style: theme.textTheme.titleSmall),
            SizedBox(height: 10.v),
            _buildUserNameGoogleTextField(context),
            SizedBox(height: 20.v),
            _buildPhoneNumberGoogleTextField(context),
            SizedBox(height: 24.v),
            CustomElevatedButton(
                text: "Continue",
                margin: EdgeInsets.symmetric(horizontal: 4.h),
                title: 'Creating Account...',
                onPressed: () async {
                  if (phoneNumberGoogleController.text.isNotEmpty &&
                      userNameGoogleController.text.isNotEmpty) {
                    Navigator.pop(context);
                    User? user = await authUser.signInWithGoogle();
                    if (user != null) {
                      //  Modals.showToast(authUser.successMessage);

                      registerUser(
                          context: ctxt,
                          isGoogle: true,
                          email: user.email,
                          password: user.email,
                          phoneNumber: phoneNumberGoogleController.text,
                          username: userNameGoogleController.text);
                    } else {
                      Modals.showToast(authUser.successMessage);
                    }
                  } else {
                    Modals.showToast('Please fill all fields');
                  }
                }),
          ],
        ),
      ),
    );
  }

  onTapSignIn(BuildContext context) {
    AppNavigator.pushAndReplacePage(context, page: LandingPage());
  }

  loginUser(BuildContext ctx) {
    
      ctx.read<AccountCubit>().loginUser(
          email: googleEmail,
          password: googleEmail);
      FocusScope.of(ctx).unfocus();
    
  }
}
