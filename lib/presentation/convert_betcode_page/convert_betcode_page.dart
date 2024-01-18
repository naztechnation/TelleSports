import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/presentation/auth/signin_screen/sign_in_screen.dart';

import '../../blocs/accounts/account.dart';
import '../../core/constants/enums.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/modals.dart';
import '../buy_tellacoins_screen/buy_tellacoins_screen.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_drop_down.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_icon_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import 'widgets/singleconversion3_item_widget.dart';

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
  TextEditingController mNHController = TextEditingController();

  TextEditingController jJhEightyTwoController = TextEditingController();

  String _bookieFromDropdownValue = 'Convert From';
  String _bookieToDropdownValue = 'Convert To';
  final List<String?> _addressSpinnerItems = ['Convert from'];

  bool isConverted = false;

  final List<String?> _addressSpinnerItems1 = [
    'Convert To',
  ];

  late AccountCubit _accountCubit;
  String? fromId = '';
  String? toId = '';
  String username = '';
  String email = '';
  String password = '';

  getUserDetails() async {
    email = await StorageHandler.getUserEmail() ?? '';
    password = await StorageHandler.getUserPassword() ?? '';
    username = await StorageHandler.getUserName() ?? '';

    _accountCubit = context.read<AccountCubit>();

    await _accountCubit.getBookies();

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

          if (user?.isActive == '0') {
            Modals.showToast('Your account is not active',
                messageType: MessageType.error);

            AppNavigator.pushAndReplacePage(context, page: SigninScreen());
          }
        } else if (state is AccountApiErr) {
          if (state.message != null) {}
        } else if (state is AccountNetworkErr) {
          if (state.message != null) {}
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                    // mNHController
                    if (!isConverted) ...[
                      CustomElevatedButton(
                          text: "Copy code",
                          margin: EdgeInsets.symmetric(horizontal: 20.h),
                          leftIcon: Container(
                              margin: EdgeInsets.only(right: 10.h),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgContentcopy,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('view details',
                                style: TextStyle(
                                    color: Colors.green[700],
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue)),
                            Text('convert again',
                                style: TextStyle(color: Colors.green[700],
                                decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue
                                )),
                          ],
                        ),
                      )
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
                                  imagePath: ImageConstant.imgIcRoundHistory,
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
                    _buildSingleConversion(context),
                    SizedBox(height: 17.v),
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
                            imagePath: ImageConstant.imgIllustrationStartup,
                            width: MediaQuery.sizeOf(context).width,
                            alignment: Alignment.bottomLeft))
                  ])
                ]))));
      },
    ));
  }

  Widget _buildTelacoinsBalance(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.all(0),
        color: appTheme.teal800,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Container(
            height: 100.v,
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
                                        child: Text("2000",
                                            style: CustomTextStyles
                                                .headlineLargeWhiteA700))
                                  ])
                                ]),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 10.v, bottom: 13.v),
                                child: CustomIconButton(
                                    height: 30.adaptSize,
                                    width: 30.adaptSize,
                                    padding: EdgeInsets.all(6.h),
                                    onTap: () {
                                      onTapBtnPlus(context);
                                    },
                                    child: CustomImageView(
                                        imagePath: ImageConstant.imgPlus)))
                          ])))
            ])));
  }

  Widget _buildBetCodeSelector(BuildContext context) {
    return Container(
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

                      int index = _addressSpinnerItems.indexOf(value);
                      fromId =
                          _accountCubit.viewModel.bookiesBookieFrom[index - 1];
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
                      _bookieFromDropdownValue = value ?? 'Convert from';

                      int index = _addressSpinnerItems1.indexOf(value);
                      fromId =
                          _accountCubit.viewModel.bookiesBookieFrom[index - 1];
                    })),
          )
        ]));
  }

  Widget _buildFrameNine(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomTextFormField(
              width: 173.h,
              controller: mNHController,
              hintText: "Enter code",
              hintStyle: CustomTextStyles.titleMediumGray700,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.h, vertical: 14.v),
              borderDecoration: TextFormFieldStyleHelper.fillBlueGray,
              filled: true,
              fillColor: appTheme.blueGray50),
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
            itemCount: 4,
            itemBuilder: (context, index) {
              return Singleconversion3ItemWidget();
            }));
  }

  Widget _buildBuyTellacoins(BuildContext context) {
    return CustomOutlinedButton(
        text: "Buy Tellacoins", margin: EdgeInsets.symmetric(horizontal: 20.h));
  }

  onTapBtnPlus(BuildContext context) {
    AppNavigator.pushAndStackPage(context, page: BuyTellacoinsScreen());
  }
}
