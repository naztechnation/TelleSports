import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_icon_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';
import 'package:tellesports/widgets/modal_content.dart';

import '../../../blocs/user/user.dart';
import '../../../core/constants/enums.dart';
import '../../../model/chat_model/group.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../notification.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/modals.dart';
import '../../buy_tellacoins_screen/buy_tellacoins_screen.dart';
import '../chat/screens/mobile_chat_screen.dart';
import '../provider/auth_provider.dart' as pro;

class TransferTellacoinsScreen extends StatelessWidget {
  final String username;
  final String transferAmount;
  final String groupName;
  final String groupImage;
  final bool isGroupLocked;
  final String groupNumber;
  final String groupId;
  final String userId;
  final String adminId;
  final String groupDescription;
  final String adminFcm;
  final String communityPrice;
  final String communityLink;
  final String pinnedMessage;
  final List<MemberData> userItem;

  const TransferTellacoinsScreen(
      {Key? key,
      required this.username,
      required this.transferAmount,
      required this.groupName,
      required this.groupImage,
      required this.groupNumber,
      required this.groupId,
      required this.userId,
      required this.adminId,
      required this.groupDescription,
      required this.adminFcm,
      required this.communityPrice,
      required this.communityLink,
      required this.pinnedMessage,
      required this.userItem,
      required this.isGroupLocked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: GiftTellacoin(
        username: username,
        transferAmount: transferAmount,
        groupName: groupName,
        groupImage: groupImage,
        groupNumber: groupNumber,
        groupId: groupId,
        userId: userId,
        adminId: adminId,
        groupDescription: groupDescription,
        adminFcm: adminFcm,
        communityPrice: communityPrice,
        communityLink: communityLink,
        pinnedMessage: pinnedMessage,
        userItem: userItem,
        isGroupLocked: isGroupLocked,
      ));
}

class GiftTellacoin extends StatefulWidget {
  final String username;
  final String transferAmount;
  final String groupName;
  final String groupImage;
  final bool isGroupLocked;
  final String groupNumber;
  final String groupId;
  final String userId;
  final String adminId;
  final String groupDescription;
  final String adminFcm;
  final String communityPrice;
  final String communityLink;
  final String pinnedMessage;
  final List<MemberData> userItem;

  GiftTellacoin(
      {Key? key,
      required this.username,
      required this.transferAmount,
      required this.groupName,
      required this.groupImage,
      required this.groupNumber,
      required this.groupId,
      required this.userId,
      required this.adminId,
      required this.groupDescription,
      required this.adminFcm,
      required this.communityPrice,
      required this.communityLink,
      required this.pinnedMessage,
      required this.userItem,
      required this.isGroupLocked})
      : super(key: key);

  @override
  State<GiftTellacoin> createState() => _GiftTellacoinState();
}

class _GiftTellacoinState extends State<GiftTellacoin> {
  TextEditingController amountController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String balance = '';
  String username = '';
  String userId = '';

  Color amountColor = Colors.black;

  Timer? _debounce;
  bool isSufficient = false;
  bool isLoading = false;

  late UserCubit _accountCubit;

  getUserBalance() async {
    balance = await StorageHandler.getUserBalance() ?? '';
    username = await StorageHandler.getUserName() ?? '';
    userId = await StorageHandler.getUserId() ?? '';

    Future.delayed(Duration(seconds: 0), () {
      setState(() {});
    });
  }

  void _asyncInitMethod() {
    _accountCubit = context.read<UserCubit>();
    amountController.text = '${widget.transferAmount}';
    amountController.addListener(updateTextColor);
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
  void initState() {
    getUserBalance();
    _asyncInitMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final groupInfo = Provider.of<pro.AuthProviders>(context, listen: true);

    updateTextColor();
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: BlocConsumer<UserCubit, UserStates>(
              listener: (context, state) {
                if (state is TransferCoinLoaded) {
                  if (state.tellacoin.success!) {
                    Modals.showToast(state.tellacoin.message ?? '');

                    StorageHandler.saveUserBalance(
                        state.tellacoin.data?.tellaCoins.toString());

                    addUserToGroup(groupInfo);
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 29.v),
                    child: Column(children: [
                      _buildTellacoinsBalance(context),
                      SizedBox(height: 39.v),
                      _buildTextField(context),
                      SizedBox(height: 24.v),
                      CustomElevatedButton(
                        text: "Transfer Tellacoins",
                        title: 'Transfering tellacoin...',
                        processing: state is TransferCoinLoading || isLoading,
                        isDisabled: isSufficient,
                        onPressed: () {
                          Modals.showDialogModal(context,
                              page: ModalContentScreen(
                                  title: 'Continue With Transfer',
                                  body: Text(
                                    'N.B: Are you sure you want to transfer ${widget.transferAmount} Tellacoins to the Admin of ${widget.groupName}. As This action can\'t be reversed.',
                                    maxLines: 8,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: appTheme.gray900,
                                      fontSize: 14.fSize,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  btnText: 'Proceed',
                                  onPressed: () {
                                    trasferTellaCoin();
                                   
                                    Navigator.pop(context);
                                  },
                                  headerColorOne:
                                      Color.fromARGB(255, 208, 151, 151),
                                  headerColorTwo:
                                      Color.fromARGB(255, 234, 132, 132)));
                        },
                      ),
                      SizedBox(height: 5.v)
                    ])),
              ),
            )));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 70.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 0.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Transfer Tellacoins",
        margin: EdgeInsets.only(
          top: 0.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }

  Widget _buildTellacoinsBalance(BuildContext context) {
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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.v, bottom: 13.v, right: 20),
                  child: CustomIconButton(
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                      padding: EdgeInsets.all(6.h),
                      onTap: () {
                        onTapBtnPlus(context);
                      },
                      child:
                          CustomImageView(imagePath: ImageConstant.imgPlus))),
            ),
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
                            balance,
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

  Widget _buildTextField(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Transfer amount (₦)", style: CustomTextStyles.titleSmallBlack900),
      SizedBox(height: 3.v),
      CustomTextFormField(
        controller: amountController,
        hintText: "ex. 20",
        readOnly: true,
        hintStyle: CustomTextStyles.titleSmallGray600,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.number,
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
              style: TextStyle(color: Colors.red, fontSize: 10),
            ),
          )),
    ]);
  }

  onTapBtnPlus(BuildContext context) {
    AppNavigator.pushAndStackPage(context,
        page: PricingPageScreen(balance: balance));
  }

  trasferTellaCoin() {
    if (_formKey.currentState!.validate()) {
      _accountCubit.transferTellaCoin(
          amount: amountController.text, username: widget.username);
    }
  }

  addUserToGroup(var groupInfo) async {
    setState(() {
      isLoading = true;
    });

    await groupInfo.addCurrentUserFromMembers(
        widget.groupId,
        [
          MemberData(
              userId: userId, dateJoined: DateTime.now(), username: username, recieveNotification: true)
        ],
        context);

    setState(() {
      isLoading = false;
    });
    groupInfo.addGroupInfo(
        groupNumber: widget.userItem.length.toString(),
        groupAdminId: widget.userItem[0].userId,
        groupId: widget.groupId,
        groupLink: widget.communityLink,
        isGroupLocked: widget.isGroupLocked,
        pinnedMessage: widget.pinnedMessage,
        groupDesription: widget.groupDescription,
        groupName: widget.groupName,
        groupPics: widget.groupImage);

    sendPushNotification(widget.adminFcm, widget.groupName,
        'Hello, you just recieved ${widget.transferAmount} Tellacoin from a new member on ${widget.groupName}');
    AppNavigator.pushAndStackPage(context,
        page: MobileChatScreen(
          widget.groupDescription,
          widget.groupNumber.toString(),
          widget.userItem,
          name: widget.groupName,
          uid: widget.groupId,
          isGroupChat: true,
          profilePic: widget.groupImage,
        ));
  }
}
