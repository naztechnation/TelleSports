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
import '../../../widgets/modals.dart';
import '../../../widgets/progress_indicator.dart';
import '../../auth/signin_screen/sign_in_screen.dart';
import '../create_new_password_screen/create_new_password_screen.dart';

// ignore_for_file: must_be_immutable
class VerifyAccountScreen extends StatefulWidget {
  final String email;
  final bool isForgetPassword;
  VerifyAccountScreen({Key? key, required this.email,   this.isForgetPassword = false}) : super(key: key);

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  TextEditingController enterDigitCodeController = TextEditingController();

  int countdown = 60;

  bool isCountdownComplete = false;

  @override
  void initState() {
    startCountdown();

    super.initState();
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
                    if (state is AccountLoaded) {
                      if (state.userData.success!) {
                        Modals.showToast(state.userData.message!,
                            messageType: MessageType.success);

                            Future.delayed(Duration(seconds: 2), (){
                              onTapLogin(context);
                            });
                      } else {
                        Modals.showToast(state.userData.message!,
                            messageType: MessageType.success);
                      }
                    } else if (state is OTPResent) {
                      Modals.showToast(state.userData.message!,
                          messageType: MessageType.success);

                      isCountdownComplete = false;
                      startCountdown();
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
                  builder: (context, state) => Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(children: [
                        Text("Verify Account",
                            style: theme.textTheme.headlineLarge),
                        SizedBox(height: 5.v),
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Code has been send to ",
                                  style:
                                      CustomTextStyles.titleSmallBluegray900_1),
                              TextSpan(
                                  text: widget.email,
                                  style: CustomTextStyles.titleSmallBlue800)
                            ]),
                            textAlign: TextAlign.left),
                        Text("Enter the code to verify your account.",
                            style: CustomTextStyles.titleSmallBluegray900),
                        SizedBox(height: 29.v),
                        _buildTextField(context),
                        SizedBox(height: 12.v),
                        if (isCountdownComplete)
                          (state is AccountProcessing)
                              ? Text('')
                              : Padding(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 1.v),
                                            child: Text("Didn’t Receive Code?",
                                                style: theme
                                                    .textTheme.bodyMedium)),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              _resendCode(context,);
                                            },
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.h),
                                                child: Text("Resend Code",
                                                    style: CustomTextStyles
                                                        .titleSmallPoppinsBlue400
                                                        .copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline))),
                                          ),
                                        )
                                      ])),
                        SizedBox(height: 7.v),
                        if (!isCountdownComplete)
                          Text("Resend code in $countdown secs",
                              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.green), ),
                        SizedBox(height: 32.v),
                        if (state is AccountProcessing) ...[
                          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 15,
                      width: 15,
                      child: ProgressIndicators.circularProgressBar()),
                      const SizedBox(width: 13,),
                  Text('Loading...', style: TextStyle(color: Colors.white),)
                ],
              ),
                        ] else ...[
                          CustomElevatedButton(
                              processing: state is AccountLoading,
                              text: "Verify Account",
                              title: 'Verifying Code...',
                              margin: EdgeInsets.symmetric(horizontal: 4.h),
                              onPressed: () {
                                _verifyCode(context);
                              }),
                        ],
                        SizedBox(height: 5.v)
                      ])),
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

  Widget _buildTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Enter Code", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: enterDigitCodeController,
              hintText: "Enter 6-digit code",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done)
        ]));
  }

  onTapVerifyAccount(BuildContext context) {
    AppNavigator.pushAndStackPage(context, page: CreateNewPasswordScreen());
  }

  onTapLogin(BuildContext context) {
    AppNavigator.pushAndReplacePage(context, page: SigninScreen());
  }

  Future<void> startCountdown() async {
    for (int i = 60; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        countdown = i;
      });
    }
    setState(() {
      isCountdownComplete = true;
    });
  }

  _verifyCode(BuildContext ctx, ) {
    if (enterDigitCodeController.text.isNotEmpty) {
      ctx.read<AccountCubit>().verifyCode(
            code: enterDigitCodeController.text.trim(),
            email: widget.email,
          );
      FocusScope.of(ctx).unfocus();
    }else{
      Modals.showToast('please enter code sent to your mail');
    }
  }

  _resendCode(BuildContext ctx,) {
    ctx.read<AccountCubit>().resendVerifyCode(
           email: widget.email,
        );
    FocusScope.of(ctx).unfocus();
  }
}
