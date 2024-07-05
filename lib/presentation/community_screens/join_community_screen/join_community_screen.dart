import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/core/constants/enums.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../notification.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_outlined_button.dart';
import '../../landing_page/landing_page.dart';
import '../provider/auth_provider.dart' as pro;

class CommunityInfoScreen extends StatefulWidget {
  final String groupImage;
  final String groupName;
  final String groupNumber;
  final String groupId;
  final String userId;
  final String groupDescription;
  final String adminFcm;
  const CommunityInfoScreen(
      {Key? key,
      required this.groupImage,
      required this.groupName,
      required this.groupNumber,
      required this.groupDescription,
      required this.groupId,
      required this.adminFcm,
      required this.userId})
      : super(key: key);

  @override
  State<CommunityInfoScreen> createState() => _CommunityInfoScreenState();
}

class _CommunityInfoScreenState extends State<CommunityInfoScreen> {
  String userId = '';

  bool isLoading = true;

  getCurrentUserId() async {
    userId = await StorageHandler.getUserId() ?? '';

    setState(() {
 
      
    });

    Future.delayed(Duration(seconds: 4),(){
        setState(() {
 
isLoading = false;
      
    });
      });
  }

  bool isUserAlreadyRequested = false;

  @override
  void initState() {
    getCurrentUserId();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final groupInfo = Provider.of<pro.AuthProviders>(context, listen: true);
    final user = Provider.of<AccountViewModel>(context, listen: true);

    checkUserExists(groupInfo);

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                  imagePath: widget.groupImage,
                                  placeHolder: ImageConstant.imgAvatar1,
                                  height: 64.adaptSize,
                                  width: 64.adaptSize,
                                  radius: BorderRadius.circular(32.h)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.h, bottom: 18.v),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.groupName,
                                            style: CustomTextStyles
                                                .titleMediumOnPrimaryBold18),
                                        SizedBox(height: 2.v),
                                        Text(
                                            (widget.groupNumber == '1')
                                                ? '${widget.groupNumber} Member'
                                                : '${widget.groupNumber} Members',
                                            style: CustomTextStyles
                                                .titleSmallBluegray900)
                                      ]))
                            ])),
                    SizedBox(height: 24.v),
                    _buildCommunityDescription(context, widget.groupDescription),
                    SizedBox(height: 50.v),
                    if(isLoading)...[
                      CircularProgressIndicator.adaptive()
                    ]else...[
                      if (isUserAlreadyRequested) ...[
                      Text("You have sent a request to join this community.",
                                            style: TextStyle()),
                    SizedBox(height: 24.v),

                      CustomElevatedButton(
                          text: "Cancel request",
                          processing: isLoading,
                          buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3C91E5)),
                          onPressed: () async {}),
                    ] else ...[
                      CustomElevatedButton(
                          text: "Join community",
                          processing: isLoading,
                          onPressed: () async {
                            if (!isUserAlreadyRequested) {
                              setState(() {
                                isLoading = true;
                              });
                  
                              await groupInfo.addUserToRequestsMembers(
                                  widget.groupId, widget.userId, context);
                  
                              sendPushNotification(
                                  widget.adminFcm,
                                  widget.groupName,
                                  'Hello, you have a pending invite from ${widget.groupName}');
                  
                              setState(() {
                                isLoading = false;
                              });
                  
                              Modals.showToast(
                                  'Request has been sent to community admin for approval',
                                  messageType: MessageType.success);
                              user.updateIndex(0);
                              AppNavigator.pushAndStackPage(context,
                                  page: LandingPage());
                            }
                          }),
                           SizedBox(height: 16.v),
                     CustomOutlinedButton(text: "Report community"),
                    // SizedBox(height: 5.v)
                    ],
                    ]
                  
                   
                  ]),
                ))));
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
        text: "Community Info",
        margin: EdgeInsets.only(
          top: 0.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }

  Widget _buildCommunityDescription(BuildContext context, String desc) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

      children: [
         Text("About ${widget.groupName}",
                  style: CustomTextStyles.titleMediumBluegray900),
                  const SizedBox(height: 12,),
        Container(
          width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(8.h),
             decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0x66F3F2F3),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0F000000),
                                offset: Offset(0, 0),
                                blurRadius: 1,
                              ),
                            ],
                          ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                   
                  Container(
                      margin: EdgeInsets.only(right: 21.h),
                      child: Text(desc,
                          maxLines: 1000,
                          overflow: TextOverflow.ellipsis,
                          style:
                              theme.textTheme.titleSmall!.copyWith(fontSize: 16)))
                ])),
      ],
    );
  }

   

  checkUserExists(var groupInfo) {
   

  for (var userIds in groupInfo.requestedMembers) {
    if (userIds.uid == userId) {
      setState(() {
        isUserAlreadyRequested = true;
      });
      break;
    }
  }

   
}
}
