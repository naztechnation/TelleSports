import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../blocs/accounts/account.dart';
import '../../../core/constants/enums.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../../widgets/modals.dart';
import '../../auth/sign_in_screen/sign_in_screen.dart';

// ignore_for_file: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  final String email;
  ChangePasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShowPassword1 = false;
  bool isShowPassword2 = false;

  showPassword1() {
    setState(() {
      isShowPassword1 = !isShowPassword1;
    });
  }

  showPassword2() {
    setState(() {
      isShowPassword2 = !isShowPassword2;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    emailController.text = widget.email;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: BlocProvider<AccountCubit>(
                lazy: false,
                create: (_) => AccountCubit(
                    accountRepository: AccountRepositoryImpl(),
                    viewModel:
                        Provider.of<AccountViewModel>(context, listen: false)),
                child: BlocConsumer<AccountCubit, AccountStates>(
                  listener: (context, state) {
                    if (state is ResetPasswordLoaded) {
                      if (state.userData.success!) {
                        Modals.showToast(state.userData.message ?? '', messageType: MessageType.success);

                        Future.delayed(
                            Duration(
                              seconds: 3,
                            ), () {
                          AppNavigator.pushAndReplacePage(context,
                              page: SigninScreen());
                        });
                      } else {
                        Modals.showToast(state.userData.message ?? '',
                            messageType: MessageType.error);
                      }
                    } else if (state is AccountApiErr) {
                      if (state.message != null) {
                        Modals.showToast(state.message ?? '',
                            messageType: MessageType.error);
                      }
                    } else if (state is AccountNetworkErr) {
                      if (state.message != null) {
                        Modals.showToast(state.message ?? '',
                            messageType: MessageType.error);
                      }
                    }
                  },
                  builder: (context, state) => Form(
                      key: _formKey,
                      child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Create New Password",
                                    style: theme.textTheme.headlineLarge),
                                SizedBox(height: 14.v),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "Please enter and confirm your new password.",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Colors.black)
                                      ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "You will need to login after you reset.",
                                    style:
                                        CustomTextStyles.titleSmallBluegray900,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 29.v),
                                _buildEmailTextField(context),
                                SizedBox(height: 11.v),
                                _buildPasswordTextField(context),
                                SizedBox(height: 11.v),
                                _buildConfirmPasswordTextField(context),
                                SizedBox(height: 32.v),
                                CustomElevatedButton(
                                    text: "Create Password",
                                    processing: state is ResetPasswordLoading,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.h),
                                    onPressed: () {
                                      onTapCreatePassword(context);
                                    }),
                                SizedBox(height: 5.v)
                              ]))),
                ))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 389.h,
        leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgVector,
          margin: EdgeInsets.fromLTRB(24.h, 20.v, 350.h, 20.v),
          onTap: () {
            Navigator.pop(context);
          },
        ));
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
            readOnly: true,
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              return Validator.validateEmail(value, 'Email');
            },
          )
        ]));
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: passwordController,
              hintText: "Enter Password",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.visiblePassword,
              obscureText: isShowPassword1,
              validator: (value) {
                return Validator.validate(value, 'Password');
              },
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
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  Widget _buildConfirmPasswordTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Confirm Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: confirmpasswordController,
              hintText: "Re-Enter Password",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              obscureText: isShowPassword2,
              validator: (value) {
                return Validator.validate(value, 'Password');
              },
              suffix: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 12.v, 8.h, 12.v),
                  child: GestureDetector(
                  onTap: () {
                    showPassword2();
                  },
                  child: isShowPassword2
                      ? Icon(
                          Icons.visibility_off,
                          size: 24,
                        )
                      : Icon(Icons.visibility, size: 24),
                )),
        )]));
  }

  onTapCreatePassword(BuildContext context) {
    //  AppNavigator.pushAndReplacePage(context, page: SigninScreen());

    if (_formKey.currentState!.validate()) {
      context.read<AccountCubit>().resetPassword(
          email: widget.email,
          password: passwordController.text.trim(),
          confirmPassword: confirmpasswordController.text.trim());
      FocusScope.of(context).unfocus();
    }
    ;
  }
}
