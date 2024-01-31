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
import '../verify_account_screen/verify_account_screen.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    if (state is AccountLoaded) {
                      if (state.userData.success!) {
                        Modals.showToast(state.userData.message ?? '',
                            messageType: MessageType.success);

                        AppNavigator.pushAndStackPage(context,
                            page: VerifyAccountScreen(
                              email: emailController.text.trim(),
                              otp: '',
                              isForgetPassword: true,
                            ));
                      } else {
                        Modals.showToast(state.userData.message ?? '',
                            messageType: MessageType.success);
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
                          child: Column(children: [
                            Text("Forgot Password",
                                style: theme.textTheme.headlineLarge),
                            SizedBox(height: 9.v),
                            Container(
                                width: 339.h,
                                margin: EdgeInsets.symmetric(horizontal: 9.h),
                                child: Text(
                                    "No worries! Enter your email address below and we will send you a code to reset password.",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: CustomTextStyles
                                        .labelLargeBluegray700)),
                            SizedBox(height: 31.v),
                            _buildTextField(context),
                            SizedBox(height: 32.v),
                            CustomElevatedButton(
                                text: "Send reset email",
                                margin: EdgeInsets.symmetric(horizontal: 4.h),
                                onPressed: () {
                                  onTapSendResetEmail(context);
                                }),
                            SizedBox(height: 5.v)
                          ]))),
                ))));
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

  Widget _buildTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("E-mail", style: theme.textTheme.titleSmall),
          SizedBox(height: 2.v),
          CustomTextFormField(
            controller: emailController,
            hintText: "Enter your email",
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              return Validator.validateEmail(value, 'Email');
            },
          )
        ]));
  }

  onTapSendResetEmail(BuildContext context) {
    if (_formKey.currentState!.validate()) {
     
       context.read<AccountCubit>().forgotPassword(
            email: emailController.text.trim(),
          );
    }
  }
}
