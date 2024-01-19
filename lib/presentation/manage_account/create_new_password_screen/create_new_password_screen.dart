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
import '../../auth/signin_screen/sign_in_screen.dart';

// ignore_for_file: must_be_immutable
class CreateNewPasswordScreen extends StatefulWidget {
  CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShowPassword1 = false;

  bool isShowPassword2 = false;

  bool isShowPassword3 = false;

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

    showPassword3() {
    setState(() {
      isShowPassword3 = !isShowPassword3;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
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
                        Modals.showToast(state.userData.message ?? '');

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
                        Text("Please enter and confirm your new password.",
                            style: CustomTextStyles.titleSmallBluegray900),
                        Text("You will need to login after you reset.",
                            style: CustomTextStyles.titleSmallBluegray900),
                        SizedBox(height: 29.v),
                        _buildOldPasswordTextField(context),
                        SizedBox(height: 11.v),
                        _buildPasswordTextField(context),
                        SizedBox(height: 11.v),
                        _buildConfirmPasswordTextField(context),
                        SizedBox(height: 32.v),
                        CustomElevatedButton(
                            text: "Create Password",
                            processing: state is ResetPasswordLoading,
                            margin: EdgeInsets.symmetric(horizontal: 4.h),
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
          onTap: (){
            Navigator.pop(context); 
          },
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(24.h, 20.v, 350.h, 20.v)));
  }

  Widget _buildOldPasswordTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: oldPasswordController,
              hintText: "Enter old password",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.visiblePassword,
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
              obscureText: isShowPassword1,
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
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
              hintText: 'Enter new password',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.visiblePassword,
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
                ),
              ),
              suffixConstraints: BoxConstraints(maxHeight: 48.v),
              obscureText: isShowPassword2,
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
              hintText: "Confirm new password",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
               validator: (value) {
                return Validator.validate(value, 'Password');
              },
              suffix: Container(
                margin: EdgeInsets.fromLTRB(30.h, 12.v, 8.h, 12.v),
                child: GestureDetector(
                  onTap: () {
                    showPassword3();
                  },
                  child: isShowPassword3
                      ? Icon(
                          Icons.visibility_off,
                          size: 24,
                        )
                      : Icon(Icons.visibility, size: 24),
                ),
              ),
              suffixConstraints: BoxConstraints(maxHeight: 48.v),
              obscureText: isShowPassword3,
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  onTapCreatePassword(BuildContext context) {
      // AppNavigator.pushAndReplacePage(context, page: SigninScreen());


       if (_formKey.currentState!.validate()) {
      context.read<AccountCubit>().changePassword(
          oldPassword: oldPasswordController.text,
          password: passwordController.text.trim(),
          confirmPassword: confirmpasswordController.text.trim());
      FocusScope.of(context).unfocus();
    }
    ;
;
  }
}
