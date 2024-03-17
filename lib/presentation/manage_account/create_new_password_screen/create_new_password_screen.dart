import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../blocs/accounts/account.dart';
import '../../../blocs/prediction/prediction.dart';
import '../../../core/constants/enums.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/firebase_auth_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../requests/repositories/prediction_repo/predict_repository_impl.dart';
import '../../../utils/validator.dart';
import '../../../widgets/modals.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
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
    final user = Provider.of<FirebaseAuthProvider>(context, listen: true);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: BlocProvider<PredictionCubit>(
                lazy: false,
                create: (_) => PredictionCubit(
                    predictRepository: PredictRepositoryImpl(),
                    viewModel:
                        Provider.of<UserViewModel>(context, listen: false)),
                child: BlocConsumer<PredictionCubit, PredictStates>(
                  listener: (context, state) {
                    if (state is PredictLoaded) {
                      if (state.predict.success ?? false) {
                        Modals.showToast( 'Prediction added successfully');

                        AppNavigator.pushAndStackPage(context, page: LandingPage());
                      } else {
                        Modals.showToast( 'Opps could  not add prediction',
                            messageType: MessageType.error);
                      }
                    } else if (state is PredictApiErr) {
                      // if (state.message != null) {
                      //   Modals.showToast(state.message ?? '',
                      //       messageType: MessageType.error);
                      // }
                    } else if (state is PredictNetworkErr) {
                      // if (state.message != null) {
                      //   Modals.showToast(state.message ?? '',
                      //       messageType: MessageType.error);
                      // }
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
                                Text(
                                    "Please enter and confirm your new password.",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                                SizedBox(height: 5.v),

                                Text("You will need to login after you reset.",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
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
            onTap: () {
              Navigator.pop(context);
            },
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(24.h, 20.v, 350.h, 20.v)));
  }

  Widget _buildOldPasswordTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
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
          Text("Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
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
          Text("Confirm Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
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
