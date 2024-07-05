import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/gift_tellacoins_screen/gift_tellacoins_screen.dart';
import 'package:tellesports/presentation/user_info_page/user_info_page.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import '../../utils/navigator/page_navigator.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../community_screens/provider/auth_provider.dart' as pro;
import 'package:provider/provider.dart' as provider;

class IndividualUserInfo extends StatefulWidget {
  final String name;
  final String image;
  final String bio;
  final String username;
  final String memberId;
  final bool isGroupAdmin;

  const IndividualUserInfo({
    Key? key,
    required this.name,
    required this.image,
    required this.bio,
    required this.username,
    required this.isGroupAdmin,
    required this.memberId,
  }) : super(key: key);

  @override
  IndividualUserInfoState createState() => IndividualUserInfoState();
}

// ignore_for_file: must_be_immutable
class IndividualUserInfoState extends State<IndividualUserInfo>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final groupInfo =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                 
                children: [
                SizedBox(height: 15.v),
                _buildFrameRow(context),
                SizedBox(height: 24.v),
                CustomElevatedButton(
                    text: "Gift Tellacoins",
                    buttonStyle: ElevatedButton.styleFrom(backgroundColor: Color(0xff3C91E5)),
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    leftIcon: Container(
                        margin: EdgeInsets.only(right: 10.h),
                        child: CustomImageView(
                            imagePath: ImageConstant.imgCardgiftcard,
                            height: 24.adaptSize,
                            width: 24.adaptSize)),
                    onPressed: () {
                      onTapGiftTellacoins(context, widget.username);
                    }),
                SizedBox(height: 24.v),
                _buildFrameColumn(
                  context: context,
                  groupName: groupInfo.groupName,
                  groupPics: groupInfo.groupPics,
                  groupNumber: groupInfo.groupNumber,
                ),
                SizedBox(height: 24.v),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0x66F3F2F3),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0F000000),
                        offset: Offset(0, 0),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 12, 8.8, 19.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 15.5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Communities in common',
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFF342E37),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 23),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgAvatar,
                                      placeHolder:
                                          ImageConstant.imgAvatar64x64,
                                      height: 64.adaptSize,
                                      width: 64.adaptSize,
                                      radius: BorderRadius.circular(32.h)),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.fromLTRB(0, 2.5, 0, 16.5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 10.5, 0),
                                              child: SizedBox(
                                                width: 243.5,
                                                child: Text(
                                                  'Pixsellz Team',
                                                  style: GoogleFonts.getFont(
                                                    'DM Sans',
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Color(0xFF1F1C21),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '₦',
                                              style: GoogleFonts.getFont(
                                                'DM Sans',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Color(0xFF3C91E5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '1,223 members',
                                          style: GoogleFonts.getFont(
                                            'DM Sans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Color(0xFF8E8E93),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 23),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgAvatar,
                                      placeHolder:
                                          ImageConstant.imgAvatar64x64,
                                      height: 64.adaptSize,
                                      width: 64.adaptSize,
                                      radius: BorderRadius.circular(32.h)),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.fromLTRB(0, 2.5, 0, 16.5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 10.5, 0),
                                              child: SizedBox(
                                                width: 243.5,
                                                child: Text(
                                                  'Pixsellz Team',
                                                  style: GoogleFonts.getFont(
                                                    'DM Sans',
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Color(0xFF1F1C21),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '₦',
                                              style: GoogleFonts.getFont(
                                                'DM Sans',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Color(0xFF3C91E5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '1,223 members',
                                          style: GoogleFonts.getFont(
                                            'DM Sans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Color(0xFF8E8E93),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgAvatar,
                                    placeHolder: ImageConstant.imgAvatar64x64,
                                    height: 64.adaptSize,
                                    width: 64.adaptSize,
                                    radius: BorderRadius.circular(32.h)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 2.5, 0, 16.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 10.5, 0),
                                            child: SizedBox(
                                              width: 243.5,
                                              child: Text(
                                                'Pixsellz Team',
                                                style: GoogleFonts.getFont(
                                                  'DM Sans',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Color(0xFF1F1C21),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '₦',
                                            style: GoogleFonts.getFont(
                                              'DM Sans',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color(0xFF3C91E5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '1,223 members',
                                        style: GoogleFonts.getFont(
                                          'DM Sans',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xFF8E8E93),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                 UserInfoPage(
                isGroupAdmin: widget.isGroupAdmin,
                memberId: widget.memberId,
                memberName: widget.name,
              )
              ]),
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
        text: "Info",
        margin: EdgeInsets.only(
          top: 0.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }

    _buildFrameRow(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 20.h, right: 0.h),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (widget.image == "" || widget.image == "null") ...[
                CustomImageView(
                    imagePath: ImageConstant.imgAvatar,
                    placeHolder: ImageConstant.imgAvatar64x64,
                    height: 64.adaptSize,
                    width: 64.adaptSize,
                    radius: BorderRadius.circular(32.h)),
              ] else ...[
                CustomImageView(
                    imagePath: widget.image,
                    placeHolder: ImageConstant.imgAvatar64x64,
                    height: 64.adaptSize,
                    width: 64.adaptSize,
                    radius: BorderRadius.circular(32.h)),
              ],
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.h, bottom: 11.v),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name,
                                style: CustomTextStyles
                                    .titleMediumOnPrimaryBold18),
                            SizedBox(height: 3.v),
                            SizedBox(
                                child: Text(widget.bio,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14)))
                          ])))
            ])));
  }

    _buildFrameColumn(
      {required BuildContext context,
      required String groupName,
      required String groupPics,
      required String groupNumber}) {
    return Container(
         height: 140,
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 13.v),
        decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0x66F3F2F3),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0F000000),
                        offset: Offset(0, 0),
                        blurRadius: 3,
                      ),
                    ],
                  ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  (widget.isGroupAdmin)
                      ? "Community created"
                      : "Community Info",
                  style: CustomTextStyles.titleMediumBluegray900),
              SizedBox(height: 14.v),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomImageView(
                    imagePath: groupPics,
                    placeHolder: ImageConstant.imgAvatar64x64,
                    height: 60.adaptSize,
                    width: 60.adaptSize,
                    radius: BorderRadius.circular(30.h)),
                Padding(
                    padding:
                        EdgeInsets.only(left: 10.h, top: 2.v, bottom: 15.v),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(groupName,
                              style: CustomTextStyles.titleMediumBlack900_1),
                          SizedBox(height: 2.v),
                          Text(
                              (groupNumber == '1')
                                  ? "${groupNumber}   Member"
                                  : "${groupNumber}   Members",
                              style: CustomTextStyles.titleSmallBluegray400)
                        ]))
              ]),
              SizedBox(height: 6.v)
            ]));
  }

  Widget _buildFrameColumn1() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 11.v),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Media", style: CustomTextStyles.titleMediumBluegray900),
              SizedBox(height: 8.v),
              Container(
                  height: 60.v,
                  width: 334.h,
                  child: TabBar(
                      controller: tabviewController,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.adaptSize,
                                width: 60.adaptSize)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.adaptSize,
                                width: 60.adaptSize)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.adaptSize,
                                width: 60.adaptSize)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.adaptSize,
                                width: 60.adaptSize)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.v,
                                width: 30.h)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgArrowRightOnprimary,
                                height: 24.adaptSize,
                                width: 24.adaptSize))
                      ]))
            ]));
  }

   

  onTapGiftTellacoins(BuildContext context, String username) {
    AppNavigator.pushAndStackPage(context,
        page: GiftTellacoinsScreen(desUserId: username));
  }
}
