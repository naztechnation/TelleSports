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

class UpdateAccountScreen extends StatefulWidget {
  UpdateAccountScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  TextEditingController accountNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String bankName = '';
  String accountNumber = '';
  String accountName = '';
  getUserData() async {
    bankName = await StorageHandler.getUserBank() ?? '';
    accountNumber = await StorageHandler.getUserAccountNumber() ?? '';
    accountName = await StorageHandler.getUserAccountName() ?? '';

    setState(() {
      if(bankName == 'null'){
         accountNameController.text = '';
      bankNameController.text = '';
      accountNumberController.text = '';
      }else{
         accountNameController.text = accountName;
      bankNameController.text = bankName;
      accountNumberController.text = accountNumber;
      }
     
    });
  }

  @override
  void initState() {
    getUserData();
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
                                Text("Update Account Details",
                                    style: theme.textTheme.headlineLarge),
                                SizedBox(height: 14.v),
                                Text(
                                    "Please enter your prefered account details.",
                                    textAlign: TextAlign.justify,

                                    style: TextStyle(fontSize: 14, letterSpacing: 0.2)),
                                    const SizedBox(height: 2,),
                                Text(
                                    "This would be used to recieve your tellacoin once you are eligible to do so.",
                                    textAlign: TextAlign.justify,
                                    
                                    style: TextStyle(fontSize: 14,  letterSpacing: 0)),
                                SizedBox(height: 29.v),
                                _buildAccountNameField(context),
                                SizedBox(height: 11.v),
                                _buildAccountNumberField(context),
                                SizedBox(height: 11.v),
                                _buildBankField(context),
                                SizedBox(height: 32.v),
                                CustomElevatedButton(
                                    text: "Update Account",
                                    title: 'Updating payment details...',
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

  Widget _buildAccountNameField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Account Name", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: accountNameController,
              hintText: "Enter account name",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.name,
              validator: (value) {
                return Validator.validate(value, 'Account name');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  Widget _buildAccountNumberField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Account Number", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: accountNumberController,
              hintText: 'Enter account number',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.number,
              validator: (value) {
                return Validator.validate(value, 'Account number');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  Widget _buildBankField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Bank Name", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: bankNameController,
              hintText: "Enter bank name",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              validator: (value) {
                return Validator.validate(value, 'Bank Name');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  onTapCreatePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<UserCubit>().updateAccount(
          bank: bankNameController.text,
          accountName: accountNameController.text.trim(),
          accountNumber: accountNumberController.text.trim());
      FocusScope.of(context).unfocus();
    }
    ;
  }
}
