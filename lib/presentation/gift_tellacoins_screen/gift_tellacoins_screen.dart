import 'package:flutter/material.dart';import 'package:tellesports/core/app_export.dart';import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';import 'package:tellesports/widgets/custom_elevated_button.dart';import 'package:tellesports/widgets/custom_icon_button.dart';import 'package:tellesports/widgets/custom_text_form_field.dart';
// ignore_for_file: must_be_immutable
class GiftTellacoinsScreen extends StatelessWidget {GiftTellacoinsScreen({Key? key}) : super(key: key);

TextEditingController amountController = TextEditingController();

@override Widget build(BuildContext context) { mediaQueryData = MediaQuery.of(context); return SafeArea(child: Scaffold(resizeToAvoidBottomInset: false, appBar: _buildAppBar(context), body: Container(width: double.maxFinite, padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 29.v), child: Column(children: [_buildTellacoinsBalance(context), SizedBox(height: 39.v), _buildTextField(context), SizedBox(height: 24.v), CustomElevatedButton(text: "Gift Tellacoins", leftIcon: Container(margin: EdgeInsets.only(right: 10.h), child: CustomImageView(imagePath: ImageConstant.imgCardgiftcard, height: 24.adaptSize, width: 24.adaptSize))), SizedBox(height: 5.v)])))); } 
 
PreferredSizeWidget _buildAppBar(BuildContext context) { return CustomAppBar(height: 82.v, leadingWidth: 44.h, leading: AppbarLeadingImage(imagePath: ImageConstant.imgArrowBack, margin: EdgeInsets.only(left: 20.h, top: 4.v, bottom: 4.v)), centerTitle: true, title: AppbarSubtitleOne(text: "Gift Tellacoins"), styleType: Style.bgOutline_1); } 
 
Widget _buildTellacoinsBalance(BuildContext context) { return Card(clipBehavior: Clip.antiAlias, elevation: 0, margin: EdgeInsets.all(0), color: appTheme.teal800, shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyle.roundedBorder8), child: Container(height: 72.v, width: 350.h, decoration: AppDecoration.fillTeal.copyWith(borderRadius: BorderRadiusStyle.roundedBorder8), child: Stack(alignment: Alignment.topLeft, children: [CustomImageView(imagePath: ImageConstant.imgEllipse77, height: 41.v, width: 317.h, alignment: Alignment.bottomRight), CustomImageView(imagePath: ImageConstant.imgEllipse88, height: 40.v, width: 288.h, alignment: Alignment.topLeft), Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.fromLTRB(12.h, 10.v, 12.h, 7.v), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Tellacoins balance:".toUpperCase(), style: CustomTextStyles.bodySmallWhiteA700), Row(children: [CustomImageView(imagePath: ImageConstant.imgSettings, height: 26.adaptSize, width: 26.adaptSize, margin: EdgeInsets.only(top: 8.v, bottom: 7.v)), Padding(padding: EdgeInsets.only(left: 6.h), child: Text("200", style: CustomTextStyles.headlineLargeWhiteA700))])]), Padding(padding: EdgeInsets.only(top: 10.v, bottom: 13.v), child: CustomIconButton(height: 30.adaptSize, width: 30.adaptSize, padding: EdgeInsets.all(6.h), onTap: () {onTapBtnPlus(context);}, child: CustomImageView(imagePath: ImageConstant.imgPlus)))])))]))); } 
 
Widget _buildTextField(BuildContext context) { return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Enter amount", style: CustomTextStyles.titleSmallBlack900), SizedBox(height: 3.v), CustomTextFormField(controller: amountController, hintText: "ex. 20", hintStyle: CustomTextStyles.titleSmallGray600, textInputAction: TextInputAction.done)]); } 
/// Navigates to the buyTellacoinsScreen when the action is triggered.
onTapBtnPlus(BuildContext context) { Navigator.pushNamed(context, AppRoutes.buyTellacoinsScreen); } 
 }
