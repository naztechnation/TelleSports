import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../core/constants/enums.dart';
import '../../../utils/validator.dart';
import '../../../widgets/modals.dart';
import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../utils/navigator/page_navigator.dart';

class SubmitPredictionScreen extends StatefulWidget {
  SubmitPredictionScreen({Key? key}) : super(key: key);

  @override
  State<SubmitPredictionScreen> createState() => _SubmitPredictionScreenState();
}

class _SubmitPredictionScreenState extends State<SubmitPredictionScreen> {
  TextEditingController homeTeamController = TextEditingController();
  TextEditingController awayTeamController = TextEditingController();
  TextEditingController predictedWinnerController = TextEditingController();
  TextEditingController winnerController = TextEditingController();
  TextEditingController winnerOddController = TextEditingController();
  TextEditingController leagueController = TextEditingController();


  TextEditingController accountNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String bankName = '';
  String accountNumber = '';
  String accountName = '';
   
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: BlocProvider<UserCubit>(
                lazy: false,
                create: (_) => UserCubit(
                    userRepository: UserRepositoryImpl(),
                    viewModel:
                        Provider.of<UserViewModel>(context, listen: false)),
                child: BlocConsumer<UserCubit, UserStates>(
                  listener: (context, state) {
                    if (state is TransferCoinLoaded) {
                      if (state.tellacoin.success!) {
                        Modals.showToast(state.tellacoin.message ?? '',
                            messageType: MessageType.success);

                        Future.delayed(
                            Duration(
                              seconds: 3,
                            ), () {
                          AppNavigator.pushAndReplacePage(context,
                              page: LandingPage());
                          ;
                        });
                      } else {
                        Modals.showToast(state.tellacoin.message ?? '',
                            messageType: MessageType.error);
                      }
                    } else if (state is UserApiErr) {
                      if (state.message != null) {
                        Modals.showToast(state.message ?? '',
                            messageType: MessageType.error);
                      }
                    } else if (state is UserNetworkErr) {
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
                                Text("Submit your Predictions",
                                    style: theme.textTheme.headlineLarge),
                                SizedBox(height: 10.v),
                                Text(
                                    "Please enter your predictions here.",
                                    textAlign: TextAlign.justify,

                                    style: TextStyle(fontSize: 14, letterSpacing: 0.2)),
                                
                                SizedBox(height: 29.v),
                                _buildHomeTeamField(context),
                                SizedBox(height: 11.v),
                                _buildAwayTeamField(context),
                                SizedBox(height: 11.v),
                                _buildPredictedWinnerField(context),
                                SizedBox(height: 11.v),

                                _buildOddsField(context),

                                _buildLeagueField(context),
                                SizedBox(height: 32.v),
                                CustomElevatedButton(
                                    text: "Submit",
                                    title: 'Submitting data...',
                                    processing: state is TransferCoinLoading,
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

  Widget _buildLeagueField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("League", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: leagueController,
              hintText: "Select League",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.name,
              validator: (value) {
                return Validator.validate(value, 'League');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  Widget _buildHomeTeamField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Home Team", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: homeTeamController,
              hintText: 'Enter home way',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.number,
              readOnly: true,
              validator: (value) {
                return Validator.validate(value, 'Home team');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

   Widget _buildAwayTeamField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Away Team", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: awayTeamController,
              hintText: 'Enter away way',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.number,
              validator: (value) {
                return Validator.validate(value, 'Away team');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }


  Widget _buildPredictedWinnerField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Predicted  Winner", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: predictedWinnerController,
              hintText: "Select",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              validator: (value) {
                return Validator.validate(value, 'Predicted winner');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }


  Widget _buildOddsField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Winner\'s Odd", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: winnerOddController,
              hintText: 'Enter winners odd',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.number,
              readOnly: true,
              validator: (value) {
                return Validator.validate(value, 'Winners');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }
  onTapCreatePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // context.read<UserCubit>().updateAccount(
      //     bank: bankNameController.text,
      //     accountName: accountNameController.text.trim(),
      //     accountNumber: accountNumberController.text.trim());
      FocusScope.of(context).unfocus();
    }
    ;
  }
}
