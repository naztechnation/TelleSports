import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/common/widgets/loader.dart';
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
import '../../model/user_model/country_bank.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../utils/navigator/page_navigator.dart';


class UpdateAccountScreen extends StatelessWidget {
  const UpdateAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: UpdateAccount(),
    );
  }
}
class UpdateAccount  extends StatefulWidget {
  UpdateAccount({Key? key}) : super(key: key);

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  TextEditingController accountNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserCubit _userCubit;


  String bankName = '';
  String accountNumber = '';
  String accountName = '';
  String countryCode = '';
  String countryCurrency = '';

  List<CountryData> banks = [];

  getUserData() async {
    _userCubit = context.read<UserCubit>();

    bankName = await StorageHandler.getUserBank() ?? '';
    accountNumber = await StorageHandler.getUserAccountNumber() ?? '';
    accountName = await StorageHandler.getUserAccountName() ?? '';
    countryCurrency = await StorageHandler.getCurrency() ?? '';

    setState(() {
      if (bankName == 'null') {
        accountNameController.text = '';
        bankNameController.text = '';
        accountNumberController.text = '';
      } else {
        accountNameController.text = accountName;
        bankNameController.text = bankName;
        accountNumberController.text = accountNumber;
        countryCodeController.text = countryCurrency;
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
            body: BlocConsumer<UserCubit, UserStates>(
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
                }else if (state is CurrencyLoaded) {
                  if (state.bank.success ?? false) {
                    banks = state.bank.data?.data ?? [];
            
                      
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
                                style: TextStyle(
                                    fontSize: 14, letterSpacing: 0.2)),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                                "This would be used to recieve your tellacoin once you are eligible to do so.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 14, letterSpacing: 0)),
                            SizedBox(height: 29.v),
                            _buildCountryCodeField(context),
                           if(banks.isNotEmpty) SizedBox(height: 11.v),
                           if(banks.isNotEmpty || bankName != 'null')...[
                            _buildBankField(context),
                           ] else if(state is CurrencyLoading)...[
                            Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: Loader()),
                            )
                           ], 
                            SizedBox(height: 11.v),
                            _buildAccountNumberField(context),
                            SizedBox(height: 11.v),
                            _buildAccountNameField(context),
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
            )));
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
        padding: EdgeInsets.only(left:0.h),
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
        padding: EdgeInsets.only(left: 0.h),
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

  Widget _buildCountryCodeField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Country Currency", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: countryCodeController,
              hintText: "Select country currency",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              readOnly: true,
              suffix: Icon(
                Icons.arrow_drop_down,
                size: 20,
              ),
              validator: (value) {
                return Validator.validate(value, 'Country Currency');
              },
              onTap: () {
                Modals.showBottomSheetModal(context,
                    isScrollControlled: true,
                    heightFactor: 1,
                    isDissmissible: true,
                    page: optionWidget(
                        Provider.of<UserViewModel>(context, listen: false)
                            .flutterWaveSupportedCurrency,
                        'Select Country Currency',
                        countryCodeController, context));
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  Widget _buildBankField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Bank Name", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: bankNameController,
              hintText: "Enter bank name",
              readOnly: true,
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              suffix: Icon(
                Icons.arrow_drop_down,
                size: 20,
              ),
              validator: (value) {
                return Validator.validate(value, 'Bank Name');
              },
               onTap: () {
                Modals.showBottomSheetModal(context,
                    isScrollControlled: true,
                    heightFactor: 1,
                    isDissmissible: true,
                    page: optionWidget1(
                        banks,
                        'Select Bank',
                        bankNameController,));
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

 Widget optionWidget(List<Map<String, String>> options, String title, final controller, BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: 15,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.shrink(),
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                color: Colors.green[900],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Divider(
        height: 5,
      ),
      Expanded(
        child: ListView.builder(
          itemCount: options.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async{
                Navigator.pop(context);

                controller.text = options[index]['currency'] ?? '';
                countryCode =  options[index]['countryCode'] ?? '' ;
                await  _userCubit.getCountryBank(countryCode: countryCode
          );
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  '${index + 1}.',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  options[index]['currency'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}


  optionWidget1(List<CountryData> options, String title, final controller) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.green[900],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 5,
        ),
        
        Expanded(
          child: ListView.builder(
              itemCount: options.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    controller.text = options[index].name;

                    // filteredTeam = filterClubsByLeague(
                    //     leagueName: options[index],
                    //     leaguesWithClubs: leaguesWithClubs);
                  },
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('${index + 1}.',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(
                                      width: 13,
                                    ),
                                    SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.70,

                                      child: Text(options[index].name ??  '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 15,)
                            ],
                          ),
                        ),
                        Divider(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                );
              })),
        ),
      ],
    );
  }
}
