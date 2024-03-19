import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/manage_account/update_account.dart';

import '../../model/chat_model/group.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/modals.dart';
import '../buy_tellacoins_screen/buy_tellacoins_screen.dart';
import '../community_screens/provider/auth_provider.dart';
import 'finish_withdrawal.dart';

class WithdrawTellaCoins extends StatefulWidget {
  final String tellaCoinBalance;
  final String userSub;
  WithdrawTellaCoins(
      {Key? key, required this.tellaCoinBalance, required this.userSub})
      : super(
          key: key,
        );

  @override
  State<WithdrawTellaCoins> createState() => _WithdrawTellaCoinsState();
}

class _WithdrawTellaCoinsState extends State<WithdrawTellaCoins> {
  TextEditingController eligibleMessageController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String bank = "";
  String userId = "";
  int numberOfMembers = 0;

  bool isEligible = false;

  Timer? _debounce;
  bool isSufficient = false;

  List<Group> userGroups = [];
  List<int> membersUidLength = [];
  List<String> membersUid = [];

  bool isAnyLengthGreaterThanOrEqual = false;

  String balance = '';

  Color amountColor = Colors.black;

  bool _dataAdded = false;

  getBankDetails() async {
    bank = await StorageHandler.getUserBank() ?? "";
    userId = await StorageHandler.getUserId() ?? "";

    balance = widget.tellaCoinBalance;


    setState(() {});
  }

  @override
  void initState() {
    amountController.addListener(updateTextColor);

    getBankDetails();
    super.initState();
  }

  void updateTextColor() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        double enteredAmount = double.tryParse(amountController.text) ?? 0;
        double staticAmount = double.tryParse(balance) ?? 0;

        amountColor = enteredAmount > staticAmount ? Colors.red : Colors.black;
        if (amountController.text.isNotEmpty) {
          isSufficient = enteredAmount > staticAmount ? true : false;
        } else {
          isSufficient = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    checkEventStatus();

    

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: StreamBuilder<List<Group>>(
            stream: Provider.of<AuthProviders>(context, listen: false)
                .getUserGroups(userId),
            builder: (context, snapshot) {
              userGroups = snapshot.data ?? [];

              membersUidLength.clear();
              membersUid.clear();
              for (var group in userGroups) {
                membersUid.addAll(group.membersUid);
              }

              membersUid = removeDuplicates(membersUid);

              for (var group in userGroups) {
                int length = group.membersUid.toSet().length;
                membersUidLength.add(length);
              }

              isAnyLengthGreaterThanOrEqual =
                  isAnyLengthGreaterThanOrEqualTo100(membersUidLength);

              return Form(
                key: _formKey,

                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomElevatedButton(
                        textColor: isEligible ? Color(0xFF288763) : Colors.red,
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: isEligible
                                ? Color(0xFFEBF6F2)
                                : Colors.red.shade50,
                            foregroundColor: Color(0xFF288763)),
                        decoration: BoxDecoration(
                            color: Color(0xFFEBF6F2),
                            borderRadius: BorderRadius.circular(20)),
                        text: isEligible
                            ? "You are eligible to  withdraw tellacoins"
                            : "You are not eligible to  withdraw tellacoins",
                        buttonTextStyle: TextStyle(color: Color(0xFF288763)),
                        leftIcon: Container(
                          margin: EdgeInsets.fromLTRB(10.h, 8.v, 8.h, 8.v),
                          child: CustomImageView(
                            color: isEligible ? Color(0xFF288763) : Colors.red,
                            imagePath: ImageConstant.imgVideocameraGreen700,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.v),
                      _buildTelacoinsBalance(context),
                      SizedBox(height: 15.v),
                      _buildTextField(context),
                      SizedBox(height: 23.v),
                      Text(
                        "1 Tellacoin = N20",
                        style: TextStyle(
                          color: appTheme.gray900,
                          fontSize: 14.fSize,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15.v),
                      _buildEligibilityCont(),
                      SizedBox(height: 50.v),
                      if (bank == "" || bank == "null" || bank == null) ...[
                        GestureDetector(
                          onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page: UpdateAccountScreen());
                          },
                          child: Align(
                            child: Text(
                              'Please click to add bank details.'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ]
                       else if (int.tryParse(widget.tellaCoinBalance)! <
                          1000) ...[
                        GestureDetector(
                          onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page: PricingPageScreen(
                                  balance: widget.tellaCoinBalance,
                                ));
                          },
                          child: Align(
                            child: Text(
                              'You dont\'t have sufficient balance click to add more Tellacoin.'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ] else if (!isAnyLengthGreaterThanOrEqual) ...[
                        GestureDetector(
                          onTap: () {},
                          child: Align(
                            child: Text(
                              'You don\'t have Up to 100 members in any of the communities you are leading.'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ]
                     else if(isSufficient && amountController.text.isNotEmpty)...[] else ...[
                        CustomElevatedButton(
                          text: "Continue",
                          onPressed: () => onTapContinueBtn(context),
                        ),
                      ],
                      SizedBox(height: 5.v),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  List<String> removeDuplicates(List<String> items) {
    Set<String> uniqueItems = items.toSet();
    return uniqueItems.toList();
  }

  checkEventStatus() {
    if (bank == "" || bank == "null" || bank == null) {
      setState(() {
        isEligible = false;
      });
    } else if (int.tryParse(widget.tellaCoinBalance)! < 1000) {
      setState(() {
        isEligible = false;
      });
    } else if (!isAnyLengthGreaterThanOrEqual) {
      setState(() {
        isEligible = false;
      });
    }else if(isSufficient && amountController.text.isNotEmpty){
       setState(() {
        isEligible = false;
      });
    } else {
      setState(() {
        isEligible = true;
      });
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
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

  Widget _buildEligibilityCont() {
    return Column(
      children: [
        SizedBox(height: 17.v),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Withdrawal Eligibility ",
            style: TextStyle(
              color: appTheme.gray900,
              fontSize: 16.fSize,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 17.v),
        Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgIcRoundCheck,
              height: 17.adaptSize,
              width: 17.adaptSize,
              margin: EdgeInsets.only(bottom: 1.v),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Text(
                  'Buy a community leader plan',
                  style: CustomTextStyles.titleSmallBluegray900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgIcRoundCheck,
              height: 17.adaptSize,
              width: 17.adaptSize,
              margin: EdgeInsets.only(bottom: 1.v),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Text(
                  'Create and manage a community with at least 100 members',
                  style: CustomTextStyles.titleSmallBluegray900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgIcRoundCheck,
              height: 17.adaptSize,
              width: 17.adaptSize,
              margin: EdgeInsets.only(bottom: 1.v),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Text(
                  'Have a minimum balance of 1000 Tellacoins',
                  style: CustomTextStyles.titleSmallBluegray900,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTelacoinsBalance(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(0),
      color: Color(0xFF1E654A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Container(
        height: 85.v,
        decoration: BoxDecoration(color: Color(0xFF1E654A)),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            CustomImageView(
              color: Color(0xFF144432),
              imagePath: ImageConstant.imgEllipse74,
              height: 41.v,
              width: 317.h,
              alignment: Alignment.bottomRight,
            ),
            CustomImageView(
              color: Color(0xFF144432),
              imagePath: ImageConstant.imgEllipse84,
              height: 40.v,
              width: 288.h,
              alignment: Alignment.topLeft,
            ),
            _buildStarterPlan(context),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tellacoin balance:".toUpperCase(),
                      style: CustomTextStyles.bodySmallWhiteA700,
                    ),
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSettings,
                          height: 26.adaptSize,
                          width: 26.adaptSize,
                          margin: EdgeInsets.only(
                            top: 8.v,
                            bottom: 7.v,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: Text(
                            widget.tellaCoinBalance,
                            style: CustomTextStyles.headlineLargeWhiteA700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapContinueBtn(BuildContext context) {

    if( _formKey.currentState!.validate()){
    AppNavigator.pushAndStackPage(context, page: FinishWithdrawalScreen(coinToWithdraw: amountController.text, nairaRate: '20',));

    }
  }

  Widget _buildStarterPlan(BuildContext context) {
    return CustomElevatedButton(
      height: 33.v,
      width: (widget.userSub.toLowerCase() == 'community leader') ? 180.h : 150,
      text: widget.userSub.toUpperCase(),
      margin: EdgeInsets.only(right: 12.h),
      buttonStyle: CustomButtonStyles.fillTeal,
      buttonTextStyle: CustomTextStyles.labelLargeInter,
      alignment: Alignment.centerRight,
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter amount",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3.v),
        CustomTextFormField(
          controller: amountController,
          hintText: "Minimum 500",
          readOnly: isEligible ? false : true,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.number,
          borderDecoration: isSufficient && amountController.text.isNotEmpty ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: appTheme.red600,
            width: 1,
          ),
        ): OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: appTheme.blueGray100,
                width: 1,
              ),
            ),
           onChanged: (value) {
          _formKey.currentState!.validate();
        },
         validator: (value) {
          return Validator.validate(value, 'Amount');
        },
        ),
        Visibility(
          visible: isSufficient && amountController.text.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'Insufficient funds',
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
          )),
      ],
    );
  }

  bool isAnyLengthGreaterThanOrEqualTo100(List<int> lengths) {
    for (var length in lengths) {
      if (length >= 100) {
        return true;
      }
    }
    return false;
  }
}
