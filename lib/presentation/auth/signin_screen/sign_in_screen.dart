import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/auth/sign_up_screen/sign_up_screen.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../blocs/accounts/account.dart';
import '../../../core/constants/enums.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../../widgets/modals.dart';
import '../../landing_page/landing_page.dart';
import '../../manage_account/verify_account_screen/verify_account_screen.dart';

// ignore_for_file: must_be_immutable
class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();

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
                    if (state is AccountUpdated) {
                      if (state.user.success ?? false) {
                        StorageHandler.saveIsLoggedIn('true');
                        StorageHandler.saveUserToken(state.user.token?.token);
                        StorageHandler.saveUserEmail(state.user.user?.email);
                        StorageHandler.saveUserPhone(state.user.user?.phone);
                           
                        onTapSignIn(context);
                      } else {

                       if(state.user.error?.isNotEmpty ?? false){
                        Modals.showToast(state.user.error ?? '');
                          resendCode(context);
                       }else{
                         if(state.user.message?.isNotEmpty ?? false){
                          Modals.showToast(state.user.message ?? '',
                            messageType: MessageType.error);
                        }else{
                           Modals.showToast('Failed to login',
                            messageType: MessageType.error);
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
                                SizedBox(height: 11.v),
                                _buildPasswordSection(context),
                                SizedBox(height: 13.v),
                                Row(
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
                                                                decorationColor: Colors.blue
                                                                )))),
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
                                                                decorationColor: Colors.blue
                                                                )))),
                                  ],
                                ),
                                SizedBox(height: 29.v),
                                CustomElevatedButton(
                                    processing: state is AccountLoading,
                                    title: 'Authenticating...',
                                    onPressed: (() => loginUser(context)),
                                    text: "Login",
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.h)),
                                Spacer(),
                                Text("or login with",
                                    style: CustomTextStyles.labelLargeGray600),
                                SizedBox(height: 11.v),
                                CustomOutlinedButton(
                                    text: "Sign in with Google",
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.h),
                                    leftIcon: Container(
                                        margin: EdgeInsets.only(right: 10.h),
                                        child: CustomImageView(
                                            imagePath: ImageConstant
                                                .imgSocialMediaIcons,
                                            height: 24.adaptSize,
                                            width: 24.adaptSize))),
                                SizedBox(height: 13.v),
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
                                    onPressed: () {}),
                                SizedBox(height: 10.v)
                              ]))),
                ))));
  }

  Widget _buildEmailOrPhoneSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("E-mail", style: theme.textTheme.titleSmall),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Password", style: theme.textTheme.titleSmall),
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

  loginUser(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {

     // onTapSignIn(ctx);
      ctx.read<AccountCubit>().loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      FocusScope.of(ctx).unfocus();
    }
  }
}
