import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/res/app_strings.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';

import '../../blocs/accounts/account.dart';
import '../../core/constants/enums.dart';
import '../../model/auth_model/plans_list.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../utils/app_utils.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import '../buy_tellacoins_screen/widgets/communityleader_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import '../withdraw_tellacoin.dart/withdraw_tellacoins_one_screen.dart';

import 'package:flutterwave_standard/flutterwave.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';

class PricingPageScreen extends StatelessWidget {
  final String balance;
  const PricingPageScreen({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BuyTellacoinsScreen(
        balance: balance,
      ));
}

class BuyTellacoinsScreen extends StatefulWidget {
  final String balance;

  BuyTellacoinsScreen({Key? key, required this.balance})
      : super(
          key: key,
        );

  @override
  State<BuyTellacoinsScreen> createState() => _BuyTellacoinsScreenState();
}

class _BuyTellacoinsScreenState extends State<BuyTellacoinsScreen> {
  late AccountCubit _accountCubit;

  String planId = '';

  bool eventHasHappened = false;

  String email = '';

  String password = '';

  String teamId = '';

  String transactionId = '';

  String txref = '';

  String txId = '';

  String message = '';
  String plan = '';

  String amount = '';

  String selectedCurrency = '';

  String url = '';

  bool isCurrencyConverted = false;

  var uuid = const Uuid();

  bool isPaymentSuccess = false;

  String selectedPlan = '';

  List<Datum> plans = [];

  bool isLoading = false;

  Map<String, String> firstPricing = {
    "NGN": '500',
    "AUD": '1.69',
    "CAD": '1.49',
    "RWF": '1200',
    "XAF": '500',
    "UGX": '4000',
    "KES": '150',
    "ZAR": '20',
    "USD": '1',
    "GHS": '11.47',
    "TZS": '2500',
  };

  Map<String, String> secondPricing = {
    "NGN": '1000',
    "AUD": '2.69',
    "CAD": '2.99',
    "RWF": '1200',
    "XAF": '1000',
    "UGX": '8000',
    "KES": '300',
    "ZAR": '35',
    "USD": '1.99',
    "GHS": '21',
    "TZS": '4000',
  };

  Map<String, String> thirdPricing = {
    "NGN": '2000',
    "AUD": '3.69',
    "CAD": '5.99',
    "RWF": '1200',
    "XAF": '2000',
    "UGX": '16000',
    "KES": '600',
    "ZAR": '70',
    "USD": '2.99',
    "GHS": '40',
    "TZS": '8000',
  };

  Future<void> checkEventStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final eventTimestamp = prefs.getInt('eventTimestamp');
    if (eventTimestamp != null) {
      final currentTime = DateTime.now();
      final elapsedTimeInHours = currentTime
          .difference(DateTime.fromMillisecondsSinceEpoch(eventTimestamp))
          .inHours;

      if (elapsedTimeInHours >= 24) {
        prefs.remove('eventTimestamp');
        setState(() {
          eventHasHappened = false;
        });
      } else {
        setState(() {
          eventHasHappened = true;
        });
      }
    }
  }

  getUserData() async {
    email = await StorageHandler.getUserEmail() ?? '';
    password = await StorageHandler.getUserPassword() ?? '';
    plan = await StorageHandler.getUserPlan() ?? '';

    setState(() {});
  }

  removeTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('eventTimestamp');
    setState(() {
      eventHasHappened = false;
    });
  }

  _handlePaymentInitialization({
    required String price,
  }) async {
    final Customer customer = Customer(email: email);

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: AppStrings.flutterwaveApiKey,
        currency: selectedCurrency,
        redirectUrl: 'https://tellasport.com',
        txRef: transactionId,
        amount: price,
        customer: customer,
        paymentOptions:
            "ussd, card, barter, payattitude, account, banktransfer, mpesa, mobilemoneyghana, mobilemoneyfranco, mobilemoneyuganda, mobilemoneyrwanda, mobilemoneyzambia, nqr",
        customization: Customization(
          title: "Tellasport",
          logo: ImageConstant.imgNavIcons,
        ),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();

    if (response != null) {
      txId = response.transactionId ?? '';
      if (txId != '') {
        markEventAsHappened(transactId: txId, plansId: planId);

        message = 'Payment Ref: ${response.txRef}';
        url = AppStrings.confirmPaymentUrl;
        _accountCubit.confirmSubscriptionn(txId, url, planId).then((value) => {
              if (_accountCubit.viewModel.paymentStatus)
                {
                  AppNavigator.pushAndReplacePage(context,
                      page: LandingPage(
                         
                      )),

                  Modals.showToast('Payment Processed Successfully.',
                      messageType: MessageType.success)
                }
            });
      }
    } else {
      Modals.showToast('Unable to make payment Successfully.',
          messageType: MessageType.error);
    }
  }

  @override
  void initState() {
    transactionId = uuid.v1();
    _asyncInitMethod();
    getUserData();
    checkEventStatus();

    super.initState();
  }

  void _asyncInitMethod() {
    _accountCubit = context.read<AccountCubit>();
    _accountCubit.plansList();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child:
          BlocConsumer<AccountCubit, AccountStates>(listener: (context, state) {
        if (state is ReconfirmPayLoaded) {
          if (state.userData.success!) {
            removeTime();

            Modals.showToast("Payment confirmed successfully",
                messageType: MessageType.success);
          } else {
            removeTime();

            Modals.showToast('This transaction has already been confirmed');

            AppNavigator.pushAndReplacePage(context, page: LandingPage());
          }
        }
      }, builder: (context, state) {
        if (state is AccountProcessing) {
          return Container(
              color: Colors.white,
              height: AppUtils.deviceScreenSize(context).height,
              width: AppUtils.deviceScreenSize(context).width,
              child: const LoadingPage(length: 20));
        } else if (state is SubscriptionProcessing) {
          return Container(
              color: Colors.white,
              height: AppUtils.deviceScreenSize(context).height,
              width: AppUtils.deviceScreenSize(context).width,
              child: const LoadingPage(length: 20));
        } else if (state is ReconfirmPayProcessing) {
          return Container(
              color: Colors.white,
              height: AppUtils.deviceScreenSize(context).height,
              width: AppUtils.deviceScreenSize(context).width,
              child: const LoadingPage(length: 20));
        } else if (state is SubscriptionNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _accountCubit
                .confirmSubscriptionn(txId, url, planId)
                .then((value) => {Modals.showToast(txId)}),
          );
        } else if (state is SubscriptionApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _accountCubit
                .confirmSubscriptionn(txId, url, planId)
                .then((value) => {}),
          );
        } else if (state is SubscriptionLoaded) {
          _accountCubit.plansList();
        } else if (state is AccountNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _accountCubit.plansList(),
          );
        } else if (state is AccountApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _accountCubit.plansList(),
          );
        } else if (state is PlansLoaded) {
          plans = state.plansList.data!.reversed.toList() ?? [];
        }
        return (plans.isEmpty)
            ? Scaffold(body: const Center(child: Text('No Plans Available')))
            : Scaffold(
                appBar: _buildAppBar(context),
                body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 21.v),
                  child: Column(
                    children: [
                      _buildTelacoinsBalance(context),
                      SizedBox(height: 16.v),
                      _buildCashTellacoins(context),
                      SizedBox(height: 16.v),
                      Divider(
                        color: appTheme.gray50001,
                      ),
                      SizedBox(height: 15.v),
                      _buildCommunityLeader(context),
                    ],
                  ),
                ),
                bottomNavigationBar: (eventHasHappened)
                    ? SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: CustomElevatedButton(
                                  buttonStyle: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                                  onPressed: () {
                                    reconfirmTransaction();
                                  },
                                  processing: isLoading,
                                  text: 'Reconfirm payment'),
                            )
                          ],
                        ))
                    : const SizedBox.shrink(),
              );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Buy Tellacoins",
        margin: EdgeInsets.only(
          top: 50.v,
          bottom: 8.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildStarterPlan(BuildContext context) {
    return CustomElevatedButton(
      height: 31.v,
      width: (plan.toUpperCase() == 'community leader'.toUpperCase())
          ? 150.h
          : 136.h,
      text: plan.toUpperCase(),
      margin: EdgeInsets.only(
        right: 12.h,
        left: 12.h,
      ),
      buttonStyle: CustomButtonStyles.fillTeal,
      buttonTextStyle: CustomTextStyles.labelLargeInter,
      alignment: Alignment.centerRight,
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
        width: 350.h,
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
                            widget.balance,
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

  Widget _buildCashTellacoins(BuildContext context) {
    return CustomOutlinedButton(
        leftIcon: CustomImageView(
          imagePath: ImageConstant.cash,
        ),
        onPressed: () =>
            AppNavigator.pushAndStackPage(context, page: WithdrawTellaCoins(tellaCoinBalance: widget.balance,userSub: plan,)),
        text: "   Cash Tellacoins",
        margin: EdgeInsets.symmetric(horizontal: 20.h));
  }

  Widget _buildCommunityLeader(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 24.v,
            );
          },
          itemCount: plans.length,
          itemBuilder: (context, index) {
            if (plans[index].name == 'Free Plan') {
              return SizedBox.shrink();
            } else {
              return CommunityleaderItemWidget(
                plans: plans[index],
                onTap: () {
                  setState(() {
                    selectedPlan = plans[index].name ?? '';
                    planId = plans[index].id.toString();
                  });
                  Modals.showBottomSheetModal(context,
                      isScrollControlled: false,
                      isDissmissible: true,
                      heightFactor: 0.7,
                      page: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 22.0),
                              child: Text('To Purchase Tellacoins Pay With...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: (() {
                                Navigator.pop(context);

                                Modals.showDialogModal(context,
                                        page: _getCurrency('flutterwave'))
                                    .then((value) => {
                                          if (selectedCurrency == '')
                                            {}
                                          else
                                            {
                                              if (selectedCurrency == 'NGN')
                                                {
                                                  _handlePaymentInitialization(
                                                      price:
                                                          plans[index].price ??
                                                              ''),
                                                }
                                              else
                                                {
                                                  _handlePaymentInitialization(
                                                      price:
                                                          plans[index].price ??
                                                              ''),
                                                }
                                            }
                                        });
                              }),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Flutterwave',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Divider(),
                            const SizedBox(height: 45),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.lock,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 13,
                                ),
                                Text('Secured Payment',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                              ],
                            ),
                          ]));
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> markEventAsHappened(
      {required String transactId, required String plansId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    prefs.setInt('eventTimestamp', currentTimestamp);
    prefs.setString('txId', transactId);
    prefs.setString('planId', plansId);

    setState(() {
      eventHasHappened = true;
    });
  }

  reconfirmTransaction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String planIdentity = prefs.getString('planId') ?? '';
    String transactionId = prefs.getString('txId') ?? '';
    String accessToken = await StorageHandler.getUserToken() ?? '';

    if (planIdentity.isNotEmpty &&
        transactionId.isNotEmpty &&
        accessToken.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await _accountCubit.reconfirmPayment(
          transactionId: transactionId,
          planId: planIdentity,
          accessToken: accessToken);
      setState(() {
        isLoading = false;
      });
    } else {
      Modals.showToast('cant verify at the moment');
    }
  }

  Widget _getCurrency(String paymentType) {
    List<String> currencies = [];
    if (paymentType == 'flutterwave') {
      currencies = [
        "NGN",
        "AUD",
        "CAD",
        "RWF",
        "XAF",
        "UGX",
        "KES",
        "ZAR",
        "USD",
        "GHS",
        "TZS",
      ];
    } else {
      currencies = [
        "NGN",
      ];
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Choose currency to pay with...'.toUpperCase(),
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1),
        const SizedBox(height: 8),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: currencies
                .map((currency) => ListTile(
                      onTap: () => {_handleCurrencyTap(currency)},
                      title: Column(
                        children: [
                          Text(
                            currency,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          const Divider(height: 1)
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      if (selectedPlan != '') {
        if (selectedPlan == 'Starter') {
          amount = firstPricing[selectedCurrency] ?? '';
        } else if (selectedPlan == 'Regular') {
          amount = secondPricing[selectedCurrency] ?? '';
        } else if (selectedPlan == 'Community leader') {
          amount = thirdPricing[selectedCurrency] ?? '';
        }
      }
    });
    Navigator.pop(context);
  }
}
