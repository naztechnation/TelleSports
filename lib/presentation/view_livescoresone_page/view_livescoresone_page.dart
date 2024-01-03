import '../view_livescoresone_page/widgets/matchcard_item_widget.dart';import 'package:flutter/material.dart';import 'package:tellesports/core/app_export.dart';import 'package:tellesports/widgets/custom_elevated_button.dart';class ViewLivescoresonePage extends StatefulWidget {const ViewLivescoresonePage({Key? key}) : super(key: key);

@override ViewLivescoresonePageState createState() =>  ViewLivescoresonePageState();

 }
class ViewLivescoresonePageState extends State<ViewLivescoresonePage> with  AutomaticKeepAliveClientMixin<ViewLivescoresonePage> {@override bool get wantKeepAlive =>  true;

@override Widget build(BuildContext context) { mediaQueryData = MediaQuery.of(context); return SafeArea(child: Scaffold(body: SizedBox(width: mediaQueryData.size.width, child: SingleChildScrollView(child: Column(children: [SizedBox(height: 16.v), Padding(padding: EdgeInsets.symmetric(horizontal: 20.h), child: Column(children: [_buildTopNavLivescores(context), SizedBox(height: 30.v), _buildMatchCard(context)]))]))))); } 
/// Section Widget
Widget _buildTopNavLivescores(BuildContext context) { return Row(mainAxisAlignment: MainAxisAlignment.center, children: [Expanded(child: Container(decoration: AppDecoration.outlineBlack900.copyWith(borderRadius: BorderRadiusStyle.roundedBorder8), child: Row(children: [CustomElevatedButton(height: 32.v, width: 65.h, text: "ALL", buttonStyle: CustomButtonStyles.fillRedTL12, buttonTextStyle: CustomTextStyles.labelMediumWhiteA700), Padding(padding: EdgeInsets.only(left: 22.h, top: 9.v, bottom: 9.v), child: Text("LIVE", style: theme.textTheme.labelMedium)), Spacer(), Padding(padding: EdgeInsets.only(top: 10.v, bottom: 7.v), child: Text("Upcoming", style: theme.textTheme.labelMedium)), Padding(padding: EdgeInsets.fromLTRB(27.h, 8.v, 18.h, 9.v), child: Text("Result", style: theme.textTheme.labelMedium))]))), CustomElevatedButton(height: 32.v, width: 80.h, text: "Search", margin: EdgeInsets.only(left: 8.h), rightIcon: Container(margin: EdgeInsets.only(left: 4.h), child: CustomImageView(imagePath: ImageConstant.imgSearch, height: 20.adaptSize, width: 20.adaptSize)), buttonStyle: CustomButtonStyles.outlineBlack, buttonTextStyle: CustomTextStyles.labelLargeInterGray500)]); } 
/// Section Widget
Widget _buildMatchCard(BuildContext context) { return ListView.separated(physics: BouncingScrollPhysics(), shrinkWrap: true, separatorBuilder: (context, index) {return SizedBox(height: 38.v);}, itemCount: 3, itemBuilder: (context, index) {return MatchcardItemWidget(onTapCardMatch: () {onTapCardMatch(context);});}); } 
/// Navigates to the viewLivescorestwoScreen when the action is triggered.
onTapCardMatch(BuildContext context) { Navigator.pushNamed(context, AppRoutes.viewLivescorestwoScreen); } 
 }
