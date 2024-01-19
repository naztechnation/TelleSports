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
  const PricingPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child:   BuyTellacoinsScreen());
}
class BuyTellacoinsScreen extends StatefulWidget {
  BuyTellacoinsScreen({Key? key})
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

  String amount = '';

  String selectedCurrency = '';

  String url = '';

  bool isCurrencyConverted = false;

  var uuid = const Uuid();

  bool isPaymentSuccess = false;

  String selectedPlan = '';

  List<Datum> plans = [];

  bool isLoading = false;

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
    required String info,
  }) async {
    final Customer customer = Customer(email: email);

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: AppStrings.flutterwaveApiKey,
        currency: selectedCurrency,
        redirectUrl: 'https://tellasport.com',
        txRef: transactionId,
        amount: amount,
        customer: customer,
        paymentOptions:
            "ussd, card, barter, payattitude, account, banktransfer, mpesa, mobilemoneyghana, mobilemoneyfranco, mobilemoneyuganda, mobilemoneyrwanda, mobilemoneyzambia, nqr",
        customization: Customization(
          title: "Tellasport",
          //logo: AppImages.ball,
        ),
        isTestMode: false);
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
                  // AppNavigator.pushAndReplacePage(context,
                  //     page: PaymentSuccess(
                  //       message: message,
                  //       info: info,
                  //     )),

      Modals.showToast('Payment Processed Successfully.',)
                }
            });
      }
    } else {
      Modals.showToast('Unable to make payment Successfully.',
          messageType: MessageType.error);
    }
  }

  final List<Map<String, dynamic>> myList = [
    {
      'amount': 'N2000',
      'title': 'Community leader',
      'color': Color(0xFF1E654A),
      'bg': Color(0xFF84CBB0),
      'body': [
        '150 Tellacoins',
        'Create and manage a community.',
        'Earn rewards and money through your community.'
      ],
      'isCommunity': true,
    },
    {
      'amount': 'N1500',
      'title': 'Regular',
      'color': Color(0xFF1E654A),
      'bg': Color(0xFF84CBB0),
      'body': [
        '100 Tellacoins',
        'Join communities and connect with other users.',
      ],
      'isFlagTrue': false,
    },
    {
      'amount': 'N700',
      'title': 'Starter',
      'color': Color(0xFF1E654A),
      'bg': Color(0xFF84CBB0),
      'body': [
        '50 Tellacoins',
        'Join communities and connect with other users.',
      ],
      'isFlagTrue': false,
    },
  ];


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
      child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
               if (state is ReconfirmPayLoaded) {
                

                if (state.userData.success!) {

                  removeTime();

                   

                      Modals.showToast("Payment confirmed successfully", messageType: MessageType.success);
                }else{
                  removeTime();

                  Modals.showToast('This transaction has already been confirmed');
                  
                  AppNavigator.pushAndReplacePage(context,
                              page: LandingPage(
                               
                              ));
                }
              }
            },
            builder: (context, state) {
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
              }  else if (state is SubscriptionNetworkErr) {
               
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
              }
              //  else if (state is CurrencyLoaded) {
              //   _accountCubit.plansList();
              //   selectedCurrency = '';
              // }
               else if (state is AccountNetworkErr) {
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
                plans = state.plansList.data ?? [];}
                return (plans.isEmpty)
                    ? const Center(child: Text('No Plans Available'))
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
      height: 23.v,
      width: 106.h,
      text: "Starter plan".toUpperCase(),
      margin: EdgeInsets.only(right: 12.h),
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
                            "200",
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
        onPressed: () => AppNavigator.pushAndStackPage(context, page: WithdrawTellaCoins()),
        text: "  Cash Tellacoins",
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
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return CommunityleaderItemWidget(
              data: myList[index],
              body: myList[index]['body'],
            );
          },
        ),
      ),
    );
  }



   Future<void> markEventAsHappened({required String transactId,required String plansId}) async {
    
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

    if(planIdentity.isNotEmpty && transactionId.isNotEmpty && accessToken.isNotEmpty){
      
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
    }else{
      Modals.showToast('cant verify at the moment');
       
    }

   
  }
}
