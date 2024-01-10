import '../convert_betcodesone_one_page/widgets/singleconversion_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_drop_down.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_icon_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

class ConvertBetcodesoneOnePage extends StatefulWidget {
  const ConvertBetcodesoneOnePage({Key? key}) : super(key: key);

  @override
  ConvertBetcodesoneOnePageState createState() =>
      ConvertBetcodesoneOnePageState();
}

// ignore_for_file: must_be_immutable
class ConvertBetcodesoneOnePageState extends State<ConvertBetcodesoneOnePage>
    with AutomaticKeepAliveClientMixin<ConvertBetcodesoneOnePage> {
  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  TextEditingController entercodeController = TextEditingController();

  TextEditingController convertedcodeController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
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
                    SizedBox(height: 12.v),
                    _buildFrameNine(context),
                    SizedBox(height: 12.v),
                    CustomElevatedButton(
                        text: "Convert code",
                        margin: EdgeInsets.symmetric(horizontal: 20.h),
                        buttonStyle: CustomButtonStyles.fillBlueGray,
                        buttonTextStyle: CustomTextStyles.titleSmallGray600),
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
                    _buildSingleConversion(context)
                  ])
                ])))));
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
            height: 72.v,
            width: 350.h,
            decoration: AppDecoration.fillTeal
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
            child: Stack(alignment: Alignment.topLeft, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse7,
                  height: 41.v,
                  width: 317.h,
                  alignment: Alignment.bottomRight),
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse8,
                  height: 40.v,
                  width: 288.h,
                  alignment: Alignment.topLeft),
              Padding(
                  padding: EdgeInsets.only(right: 12.h),
                  child: CustomIconButton(
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                      padding: EdgeInsets.all(6.h),
                      alignment: Alignment.centerRight,
                      onTap: () {
                        onTapBtnPlus(context);
                      },
                      child:
                          CustomImageView(imagePath: ImageConstant.imgPlus))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 12.h),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tellacoin balance:".toUpperCase(),
                                style: CustomTextStyles.bodySmallWhiteA700),
                            Row(children: [
                              CustomImageView(
                                  imagePath: ImageConstant.imgSettings,
                                  height: 26.adaptSize,
                                  width: 26.adaptSize,
                                  margin:
                                      EdgeInsets.only(top: 8.v, bottom: 7.v)),
                              Padding(
                                  padding: EdgeInsets.only(left: 6.h),
                                  child: Text("2090",
                                      style: CustomTextStyles
                                          .headlineLargeWhiteA700))
                            ])
                          ])))
            ])));
  }

   
  Widget _buildBetCodeSelector(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 9.v),
        decoration: AppDecoration.fillWhiteA,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 5.v),
              child: CustomDropDown(
                  width: 108.h,
                  icon: Container(
                      margin: EdgeInsets.only(left: 4.h),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgIconparksoliddownone,
                          height: 16.adaptSize,
                          width: 16.adaptSize)),
                  hintText: "Convert from",
                  items: dropdownItemList,
                  onChanged: (value) {})),
          Spacer(flex: 42),
          CustomImageView(
              imagePath: ImageConstant.imgSwapHoriz,
              height: 30.adaptSize,
              width: 30.adaptSize),
          Spacer(flex: 57),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 5.v),
              child: CustomDropDown(
                  width: 91.h,
                  icon: Container(
                      margin: EdgeInsets.only(left: 4.h),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgIconparksoliddownone,
                          height: 16.adaptSize,
                          width: 16.adaptSize)),
                  hintText: "Convert to",
                  items: dropdownItemList1,
                  onChanged: (value) {}))
        ]));
  }

   
  Widget _buildFrameNine(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomTextFormField(
              width: 173.h,
              controller: entercodeController,
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
                  controller: convertedcodeController,
                  hintText: "Converted code",
                  textInputAction: TextInputAction.done,
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
              return SingleconversionItemWidget();
            }));
  }

  /// Navigates to the buyTellacoinsScreen when the action is triggered.
  onTapBtnPlus(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.buyTellacoinsScreen);
  }
}
