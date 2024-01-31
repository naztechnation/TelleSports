import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/presentation/auth/signin_screen/sign_in_screen.dart';

import '../../blocs/accounts/account.dart';
import '../../core/constants/enums.dart';
import '../../handlers/secure_handler.dart';
import '../../model/auth_model/bookies_details.dart';
import '../../model/auth_model/converter_history.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/modal_content.dart';
import '../../widgets/modals.dart';
import '../../widgets/progress_indicator.dart';
import '../buy_tellacoins_screen/buy_tellacoins_screen.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_drop_down.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_icon_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import 'converted_code.dart';
import 'widgets/singleconversion_history.dart';

class ConvertBetcodes extends StatelessWidget {
  const ConvertBetcodes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: ConvertBetcodesPage());
}

class ConvertBetcodesPage extends StatefulWidget {
  const ConvertBetcodesPage({Key? key}) : super(key: key);

  @override
  ConvertBetcodesPageState createState() => ConvertBetcodesPageState();
}

// ignore_for_file: must_be_immutable
class ConvertBetcodesPageState extends State<ConvertBetcodesPage>
    with AutomaticKeepAliveClientMixin<ConvertBetcodesPage> {
  TextEditingController converterCodeController = TextEditingController();

  TextEditingController jJhEightyTwoController = TextEditingController();

  String _bookieFromDropdownValue = 'Convert From';
  String _bookieToDropdownValue = 'Convert To';
  List<String?> _addressSpinnerItems = [];

  bool isConverted = false;

  String destinationCode = '';

  int notConvertedEvents = 0;

  List<String?> _addressSpinnerItems1 = [];

  late AccountCubit _accountCubit;

  String? fromId = '';
  String? toId = '';
  String username = '';
  String email = '';
  String password = '';
  String balance = '0';

  BookiesDetails? bookie;

  List<ListElement>? bookingEventLists = [];

  List<ListElement>? notConvertedBookies = [];

  List<ConverterHistoryData>? convertionHistoties = [];

  getUserDetails() async {
    _addressSpinnerItems = ['Convert from'];
    _addressSpinnerItems1 = ['Convert to'];

    email = await StorageHandler.getUserEmail() ?? '';
    password = await StorageHandler.getUserPassword() ?? '';
    username = await StorageHandler.getUserName() ?? '';
    balance = await StorageHandler.getUserBalance() ?? '';

    _accountCubit = context.read<AccountCubit>();
    await _accountCubit.getConversionHistory();

    await _accountCubit.getBookies();
    await _accountCubit.getNotifications();

    setState(() {
      if (password == '' || email == '') {
      } else {
        _accountCubit.loginUser(email: email, password: password);
      }
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: BlocConsumer<AccountCubit, AccountStates>(
      listener: (context, state) {
        if (state is BookieListLoaded) {
          _addressSpinnerItems.addAll(_accountCubit.viewModel.bookiesFrom);
          _addressSpinnerItems1.addAll(_accountCubit.viewModel.bookiesTo);
        }
        if (state is AccountProcessing) {
        } else if (state is AccountUpdated) {
          final user = state.user.user;

          if (state.user.success ?? false) {
            StorageHandler.saveIsLoggedIn('true');
            StorageHandler.saveUserToken(state.user.token?.token);
            StorageHandler.saveUserEmail(state.user.user?.email);
            StorageHandler.saveUserPhone(state.user.user?.phone);
            StorageHandler.saveUserName(state.user.user?.username);

            StorageHandler.saveUserPlan(state.user.plan?.name);
            StorageHandler.saveUserBalance(
                state.user.tellacoinBalance.toString());


            StorageHandler.saveUserPhoto(state.user.profilePicture.toString());
            StorageHandler.saveUserAccountName(
                state.user.userWallet?.accountName.toString());
            StorageHandler.saveUserAccountNumber(
                state.user.userWallet?.accountNumber.toString());
            StorageHandler.saveUserBank(state.user.userWallet?.bank.toString());

            StorageHandler.saveUserPassword(password);

            balance = state.user.tellacoinBalance.toString();
          }
          if (user?.isActive == '0') {
            Modals.showToast('Your account is not active',
                messageType: MessageType.error);

            AppNavigator.pushAndReplacePage(context, page: SigninScreen());
          }
        } else if (state is BookingsLoaded) {
          bookie = _accountCubit.viewModel.bookiesDetails;

          destinationCode =
              bookie?.data?.data?.conversion?.destinationCode ?? '';

          jJhEightyTwoController.text = destinationCode;

          bookingEventLists = _accountCubit.viewModel.getUniformLists;

          notConvertedBookies = _accountCubit.viewModel.notConvertedBookies;

          notConvertedEvents =
              (bookingEventLists!.length - notConvertedBookies!.length);

          isConverted = true;
        } else if (state is BookingsError) {
          Modals.showDialogModal(context,
              page: ModalContentScreen(
                  title: 'Network Error',
                  body:
                      'Your conversion could not be completed because we could not reach our servers. Reset your internet connection and try again.',
                  btnText: 'Cancel',
                  headerColorOne: Color.fromARGB(255, 208, 151, 151),
                  headerColorTwo: Color.fromARGB(255, 234, 132, 132)));
        } else if (state is BookingsNetworkErr) {
          Modals.showDialogModal(context,
              page: ModalContentScreen(
                  title: 'Network Error',
                  body:
                      'Your conversion could not be completed because we could not reach our servers. Reset your internet connection and try again.',
                  btnText: 'Cancel',
                  headerColorOne: Color.fromARGB(255, 208, 151, 151),
                  headerColorTwo: Color.fromARGB(255, 234, 132, 132)));
        } else if (state is BookingsApiErr) {
          Modals.showDialogModal(context,
              page: ModalContentScreen(
                  title: 'Network Error',
                  body:
                      'Your conversion could not be completed because we could not reach our servers. Reset your internet connection and try again.',
                  btnText: 'Cancel',
                  headerColorOne: Color.fromARGB(255, 208, 151, 151),
                  headerColorTwo: Color.fromARGB(255, 234, 132, 132)));
        } else if (state is AccountApiErr) {
          if (state.message != null) {}
        } else if (state is AccountNetworkErr) {
          if (state.message != null) {}
        } else if (state is ConverterHistoryLoaded) {
          convertionHistoties = _accountCubit.viewModel.convertionHistoties;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: RefreshIndicator(
            onRefresh: () async {
              _accountCubit.loginUser(email: email, password: password);
              await _accountCubit.getConversionHistory();
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SizedBox(
                    width: mediaQueryData.size.width,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(height: 16.v),
                      Column(children: [
                        _buildTelacoinsBalance(context),
                        SizedBox(height: 24.v),
                        Divider(),
                        SizedBox(height: 23.v),
                        _buildBetCodeSelector(context),
                        SizedBox(height: 14.v),
                        _buildFrameNine(context),
                        SizedBox(height: 14.v),
                        if (isConverted) ...[
                          CustomElevatedButton(
                            text: "Copy code",
                            margin: EdgeInsets.symmetric(horizontal: 20.h),
                            leftIcon: Container(
                                margin: EdgeInsets.only(right: 10.h),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgContentcopy,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize)),
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: destinationCode));
                              Modals.showToast('${destinationCode} copied');
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    AppNavigator.pushAndStackPage(context,
                                        page: ConvertedCodePage(
                                          destinationCode: destinationCode,
                                          bookie: bookie,
                                          bookingEventLists: bookingEventLists,
                                          notConvertedEvents:
                                              notConvertedEvents,
                                        ));
                                  }),
                                  child: Text('view details',
                                      style: TextStyle(
                                          color: Colors.green[700],
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.green[700])),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isConverted = false;
                                    });
                                  },
                                  child: Text('convert again',
                                      style: TextStyle(
                                          color: Colors.green[700],
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.green[700])),
                                ),
                              ],
                            ),
                          )
                        ] else ...[
                          CustomElevatedButton(
                            text: "Convert Code",
                            processing: state is BookingsProcessing,
                            title: 'Converting...',
                            isDisabled: !(converterCodeController
                                    .text.isNotEmpty &&
                                _bookieFromDropdownValue != 'Convert from' &&
                                _bookieToDropdownValue != 'Convert to'),
                            buttonTextStyle: TextStyle(
                                color: !(converterCodeController
                                            .text.isNotEmpty &&
                                        _bookieFromDropdownValue !=
                                            'Convert from' &&
                                        _bookieToDropdownValue != 'Convert to')
                                    ? Color(0xFF858287)
                                    : Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            margin: EdgeInsets.symmetric(horizontal: 20.h),
                            onPressed: () {
                              if (int.parse(balance) <= 0) {
                                Modals.showDialogModal(context,
                                    page: ModalContentScreen(
                                        onPressed: () {
                                          onTapBtnPlus(context);
                                        },
                                        title: 'Insufficient Balance',
                                        body:
                                            ' You dont have a sufficient balance to convert your codes now. Get a top up from us to continue converting...',
                                        btnText: 'Top Up',
                                        headerColorOne:
                                            Color.fromARGB(255, 208, 151, 151),
                                        headerColorTwo: Color.fromARGB(
                                            255, 234, 132, 132)));
                              } else {
                                _accountCubit.convertBetCode(
                                    from: fromId ?? '',
                                    to: toId ?? '',
                                    bookingCode: converterCodeController.text,
                                    apiKey: '');
                              }
                            },
                          ),
                        ],
                        SizedBox(height: 24.v),
                        Divider(),
                        SizedBox(height: 23.v),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 20.h),
                                child: Row(children: [
                                  CustomImageView(
                                      imagePath:
                                          ImageConstant.imgIcRoundHistory,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize,
                                      margin: EdgeInsets.only(bottom: 1.v)),
                                  Padding(
                                      padding: EdgeInsets.only(left: 4.h),
                                      child: Text("Conversion History",
                                          style: CustomTextStyles
                                              .titleMediumBlack900Bold))
                                ]))),
                        SizedBox(height: 16.v),
                        if (state is ConverterHistoryLoading) ...[
                          ProgressIndicators.circularProgressBar()
                        ] else ...[
                          if (convertionHistoties?.isNotEmpty ?? false) ...[
                            _buildSingleConversion(context)
                          ] else ...[
                            SizedBox(height: 24.v),
                            Text(
                                "Start converting betcodes from 200 available bookies!",
                                style: CustomTextStyles.labelLargeBlack900),
                            SizedBox(height: 10.v),
                            _buildBuyTellacoins(context),
                            SizedBox(height: 11.v),
                            Container(
                                height: 198.v,
                                width: 193.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 28.h, vertical: 25.v),
                                child: CustomImageView(
                                    fit: BoxFit.cover,
                                    imagePath:
                                        ImageConstant.imgIllustrationStartup,
                                    width: MediaQuery.sizeOf(context).width,
                                    alignment: Alignment.bottomLeft))
                          ],
                        ],
                      ]),
                      SizedBox(height: 24.v),
                    ])))),
          ),
        );
      },
    ));
  }

  Widget _buildTelacoinsBalance(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: appTheme.teal800,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Container(
            height: 90.v,
            width: 350.h,
            decoration: AppDecoration.fillTeal.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
                color: Color(0xFFF288763)),
            child: Stack(alignment: Alignment.topLeft, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse72,
                  height: 41.v,
                  width: 317.h,
                  color: Color(0xFFF1E654A),
                  alignment: Alignment.bottomRight),
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse82,
                  height: 40.v,
                  width: 288.h,
                  alignment: Alignment.topLeft,
                  color: Color(0xFFF1E654A)),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(12.h, 10.v, 12.h, 7.v),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Tellacoin balance:".toUpperCase(),
                                      style:
                                          CustomTextStyles.bodySmallWhiteA700),
                                  Row(children: [
                                    CustomImageView(
                                        imagePath: ImageConstant.imgSettings,
                                        height: 26.adaptSize,
                                        width: 26.adaptSize,
                                        margin: EdgeInsets.only(
                                            top: 8.v, bottom: 7.v)),
                                    Padding(
                                        padding: EdgeInsets.only(left: 6.h),
                                        child: Text(balance,
                                            style: CustomTextStyles
                                                .headlineLargeWhiteA700))
                                  ])
                                ]),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomIconButton(
                                  height: 30.adaptSize,
                                  width: 30.adaptSize,
                                  padding: EdgeInsets.all(6.h),
                                  onTap: () {
                                    onTapBtnPlus(context);
                                  },
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgPlus)),
                            )
                          ])))
            ])));
  }

  Widget _buildBetCodeSelector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_addressSpinnerItems.isEmpty) {
          _accountCubit.getBookies();
        }
      },
      child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 9.v),
          decoration: AppDecoration.fillWhiteA,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 8,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.v),
                  child: CustomDropDown(
                      suffix: Container(
                        margin: EdgeInsets.only(
                          right: 8.h,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowdropdown,
                          color: Colors.green,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      icon: SizedBox.shrink(),
                      hintText: "Convert from",
                      items: _addressSpinnerItems,
                      onChanged: (value) {
                        _bookieFromDropdownValue = value ?? 'Convert from';
                        setState(() {});
                        int index = _addressSpinnerItems.indexOf(value);
                        fromId = _accountCubit
                            .viewModel.bookiesBookieFrom[index - 1];
                      })),
            ),
            SizedBox(
              width: 5,
            ),
            CustomImageView(
                imagePath: ImageConstant.imgSwapHoriz,
                height: 30.adaptSize,
                width: 30.adaptSize),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 8,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.v),
                  child: CustomDropDown(
                      suffix: Container(
                        margin: EdgeInsets.only(
                          right: 8.h,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowdropdown,
                          color: Colors.green,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      icon: SizedBox.shrink(),
                      hintText: "Convert to",
                      items: _addressSpinnerItems1,
                      onChanged: (value) {
                        _bookieToDropdownValue = value ?? 'Convert to';
                        setState(() {});

                        int index = _addressSpinnerItems1.indexOf(value);
                        toId =
                            _accountCubit.viewModel.bookiesBookieTo[index - 1];
                      })),
            )
          ])),
    );
  }

  Widget _buildFrameNine(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomTextFormField(
            width: 173.h,
            controller: converterCodeController,
            hintText: "Enter code",
            hintStyle: CustomTextStyles.titleMediumGray700,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.h, vertical: 14.v),
            borderDecoration: TextFormFieldStyleHelper.fillBlueGray,
            filled: true,
            fillColor: appTheme.blueGray50,
            onChanged: ((value) {
              setState(() {});
            }),
          ),
          Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: CustomTextFormField(
                  width: 173.h,
                  controller: jJhEightyTwoController,
                  hintText: "Converted code",
                  hintStyle: TextStyle(color: Colors.black26),
                  textInputAction: TextInputAction.done,
                  readOnly: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.h, vertical: 14.v),
                  borderDecoration: TextFormFieldStyleHelper.fillBlueGray,
                  filled: true,
                  fillColor: appTheme.blueGray50))
        ]));
  }

  Widget _buildSingleConversion(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.v);
            },
            itemCount: convertionHistoties!.length,
            itemBuilder: (context, index) {
              return SingleconversionHistory(
                  convertionHistoties: convertionHistoties![index]);
            }));
  }

  Widget _buildBuyTellacoins(BuildContext context) {
    return CustomOutlinedButton(
      text: "Buy Tellacoins",
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      onPressed: () {
        onTapBtnPlus(context);
      },
    );
  }

  onTapBtnPlus(BuildContext context) {
    AppNavigator.pushAndStackPage(context,
        page: PricingPageScreen(
          balance: balance,
        ));
  }
}
