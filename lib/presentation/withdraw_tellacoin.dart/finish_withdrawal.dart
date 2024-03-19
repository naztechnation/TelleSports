import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/utils/app_utils.dart';
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
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/modal_content.dart';
import '../manage_account/update_account.dart';

class FinishWithdrawalScreen extends StatelessWidget {
  final String coinToWithdraw;
  final String nairaRate;
  const FinishWithdrawalScreen({
    Key? key,
    required this.coinToWithdraw,
    required this.nairaRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: FinishWithdrawal(
          coinToWithdraw: coinToWithdraw, nairaRate: nairaRate),
    );
  }
}

class FinishWithdrawal extends StatefulWidget {
  final String coinToWithdraw;
  final String nairaRate;
  FinishWithdrawal(
      {Key? key, required this.coinToWithdraw, required this.nairaRate})
      : super(key: key);

  @override
  State<FinishWithdrawal> createState() => _FinishWithdrawalState();
}

class _FinishWithdrawalState extends State<FinishWithdrawal> {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  TextEditingController accountNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserCubit _userCubit;
  num nairaEquivalent = 0.0;

  void calculateNairaEquivalent() {
    double bitcoinAmount = double.tryParse(widget.coinToWithdraw) ?? 0;
    double nairaRate = double.tryParse(widget.nairaRate) ?? 0;

    nairaEquivalent = bitcoinAmount * nairaRate;
  }

  String bankName = '';
  String accountNumber = '';
  String accountName = '';
  String countryCode = '';

  List<CountryData> banks = [];

  getUserData() async {
    _userCubit = context.read<UserCubit>();

    bankName = await StorageHandler.getUserBank() ?? '';
    accountNumber = await StorageHandler.getUserAccountNumber() ?? '';
    accountName = await StorageHandler.getUserAccountName() ?? '';

    setState(() {
      if (bankName == 'null') {
        accountNameController.text = '';
        bankNameController.text = '';
        accountNumberController.text = '';
      } else {
        accountNameController.text = accountName;
        bankNameController.text = bankName;
        accountNumberController.text = accountNumber;
      }
    });
  }

  @override
  void initState() {
    calculateNairaEquivalent();
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
                if (state is RequestPayoutLoaded) {
                  if (state.payout.success!) {
                    Modals.showDialogModal(context,
                        page: ModalContentScreen(
                          title: 'Processing...',
                          body: Text(
                            'Your withdrawal is being processed. Your account will be credited within 24 hours.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: appTheme.gray900,
                              fontSize: 14.fSize,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          btnText: 'Done',
                          headerColorOne: Color(0xFFFDF9ED),
                          headerColorTwo: Color(0xFFFAF3DA),
                          onPressed: () {
                            AppNavigator.pushAndReplacePage(context,
                                page: LandingPage());
                          },
                        ));

                    Future.delayed(
                        Duration(
                          seconds: 5,
                        ), () {
                      AppNavigator.pushAndReplacePage(context,
                          page: LandingPage());
                      ;
                    });
                  } else {
                    Modals.showToast( 'Failed to withdraw Telacoins',
                        messageType: MessageType.error);
                  }
                } else if (state is CurrencyLoaded) {
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
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 25.v),
                            Text(
                              "Amount: ${widget.coinToWithdraw} Tellacoins",
                              style: TextStyle(
                                color: appTheme.teal900,
                                fontSize: 16.fSize,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12.v),
                            Text(
                              "Value: ${AppUtils.convertPrice(nairaEquivalent.toString())}",
                              style: TextStyle(
                                color: appTheme.teal900,
                                fontSize: 18,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 29.v),
                            _buildCountryCodeField(context),
                            SizedBox(height: 11.v),
                            _buildBankField(context),
                            SizedBox(height: 11.v),
                            _buildAccountNumberField(context),
                            SizedBox(height: 11.v),
                            _buildAccountNameField(context),
                            SizedBox(height: 32.v),
                            CustomElevatedButton(
                                text: "Withdraw Tellacoins",
                                title: 'Processing payment...',
                                processing: state is RequestPayoutLoading,
                                margin: EdgeInsets.symmetric(horizontal: 4.h),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()){
                                 _userCubit.requestPayout(currency: 'NGN', bankName: bankNameController.text, accountNumber: accountNumberController.text, accountName: accountNameController.text, bankCode: '044', amount: nairaEquivalent.toString());

                                  }
                                }),
                            SizedBox(height: 25.v),
          GestureDetector(
            
             onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page: UpdateAccountScreen());
                          },child: Text("Change payout account", style: TextStyle(color: Colors.red, fontSize: 14, decoration: TextDecoration.underline,decorationColor: Colors.red))),

                          ]))),
            )));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
        onTap: () {
          Navigator.pop(context);
        },
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Withdraw Tellacoins",
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }

  Widget _buildAccountNameField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Account Name", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: accountNameController,
              hintText: "Enter account name",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.name,
              filled: true,
              fillColor: appTheme.gray100,
              readOnly: true,
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
              readOnly: true,
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
               
              validator: (value) {
                return Validator.validate(value, 'Country Currency');
              },
              onTap: () {
                // Modals.showBottomSheetModal(context,
                //     isScrollControlled: true,
                //     heightFactor: 1,
                //     isDissmissible: true,
                //     page: optionWidget(
                //         Provider.of<UserViewModel>(context, listen: false)
                //             .flutterWaveSupportedCurrency,
                //         'Select Country Currency',
                //         countryCodeController, context));
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
              validator: (value) {
                return Validator.validate(value, 'Bank Name');
              },
              onTap: () {
                // Modals.showBottomSheetModal(context,
                //     isScrollControlled: true,
                //     heightFactor: 1,
                //     isDissmissible: true,
                //     page: optionWidget1(
                //         banks,
                //         'Select Bank',
                //         bankNameController,));
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

   

  Widget optionWidget(List<Map<String, String>> options, String title,
      final controller, BuildContext context) {
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
                onTap: () async {
                  Navigator.pop(context);

                  controller.text = options[index]['currency'] ?? '';
                  countryCode = options[index]['countryCode'] ?? '';
                  await _userCubit.getCountryBank(countryCode: countryCode);
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
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
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
                                    Text(options[index].name ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
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
              })),
        ),
      ],
    );
  }
}
