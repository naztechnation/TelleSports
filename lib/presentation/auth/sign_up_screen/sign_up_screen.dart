import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/manage_account/verify_account_screen/verify_account_screen.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../blocs/accounts/account.dart';
import '../../../core/constants/enums.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/firebase_auth_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../../widgets/modals.dart';
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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShowPassword1 = false;

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
        child: Scaffold(
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
                        onTapRegister(context);
                        Modals.showToast(state.userData.message ?? '',
                            messageType: MessageType.success);
                      }
                      //  else if (state.userData.message.username != null) {
                      //   Modals.showToast(state.userData.message.username[0] ?? '',
                      //       messageType: MessageType.success);
                      // }
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
                                      authUser.status),
                                  margin: EdgeInsets.symmetric(horizontal: 4.h),
                                  title: 'Creating Account...',
                                  onPressed: () {
                                    // registerUser(context);
                                    onTapRegister(context);
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
                                  User? user =
                                      await authUser.signInWithGoogle();
                                  if (user != null) {
                                    

                                  Modals.showToast("Google Sign-In successful. User ID: ${user.uid}");

                                  } else {
                                  Modals.showToast("Google Sign-In failed.");

                                  }

                                },
                              ),
                              SizedBox(height: 13.v),
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
                                  onPressed: () async{

                                    await authUser.signOut();

                                    Modals.showToast(authUser.successMessage);
                                    //  onTapSignInWithApple(context);
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
                ))));
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

  registerUser(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AccountCubit>().registerUser(
          username: userNameController.text.trim(),
          confirmPassword: passwordController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          phoneNumber: phoneNumberController.text.trim());
    }
  }
}
