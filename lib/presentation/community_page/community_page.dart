import '../community_page/widgets/chat_item_widget.dart';import 'package:flutter/material.dart';import 'package:tellesports/core/app_export.dart';import 'package:tellesports/widgets/custom_text_form_field.dart';class CommunityPage extends StatefulWidget {const CommunityPage({Key? key}) : super(key: key);

@override CommunityPageState createState() =>  CommunityPageState();

 }

// ignore_for_file: must_be_immutable
class CommunityPageState extends State<CommunityPage> with  AutomaticKeepAliveClientMixin<CommunityPage> {TextEditingController searchController = TextEditingController();

@override bool get wantKeepAlive =>  true;

@override Widget build(BuildContext context) { mediaQueryData = MediaQuery.of(context); return SafeArea(child: Scaffold(resizeToAvoidBottomInset: false, body: SizedBox(width: mediaQueryData.size.width, child: SingleChildScrollView(child: Column(children: [SizedBox(height: 12.v), Padding(padding: EdgeInsets.symmetric(horizontal: 20.h), child: Column(children: [CustomTextFormField(controller: searchController, hintText: "Search for communities or users", hintStyle: CustomTextStyles.titleSmallGray400, textInputAction: TextInputAction.done, prefix: Container(margin: EdgeInsets.fromLTRB(20.h, 5.v, 9.h, 5.v), child: CustomImageView(imagePath: ImageConstant.imgSearchGray400, height: 24.adaptSize, width: 24.adaptSize)), prefixConstraints: BoxConstraints(maxHeight: 34.v), contentPadding: EdgeInsets.only(top: 7.v, right: 30.h, bottom: 7.v), borderDecoration: TextFormFieldStyleHelper.fillGray, filled: true, fillColor: appTheme.gray100), SizedBox(height: 22.v), SizedBox(height: 1200.v, width: 350.h, child: Stack(alignment: Alignment.center, children: [_buildCommunityPageComponent(context), _buildChat(context)]))]))]))))); } 
 
Widget _buildCommunityPageComponent(BuildContext context) { return Align(alignment: Alignment.bottomCenter, child: Padding(padding: EdgeInsets.only(bottom: 525.v), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CustomImageView(imagePath: ImageConstant.imgDisplayPicture60x60, height: 60.adaptSize, width: 60.adaptSize, radius: BorderRadius.circular(30.h), margin: EdgeInsets.symmetric(vertical: 7.v)), Container(margin: EdgeInsets.only(left: 10.h), padding: EdgeInsets.only(top: 9.v, bottom: 8.v), decoration: AppDecoration.outlineGray600, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Pixsellz Team", style: CustomTextStyles.titleMediumBlack900_1), SizedBox(height: 2.v), Text("1,223 members", style: CustomTextStyles.titleSmallBluegray400), SizedBox(height: 12.v)]))]))); } 
 
Widget _buildChat(BuildContext context) { return Align(alignment: Alignment.center, child: ListView.separated(physics: BouncingScrollPhysics(), shrinkWrap: true, separatorBuilder: (context, index) {return SizedBox(height: 1.v);}, itemCount: 15, itemBuilder: (context, index) {return ChatItemWidget(onTapCommunityPageComponent: () {onTapCommunityPageComponent(context);});})); } 
/// Navigates to the communityInfoScreen when the action is triggered.
onTapCommunityPageComponent(BuildContext context) { Navigator.pushNamed(context, AppRoutes.communityInfoScreen); } 
 }
