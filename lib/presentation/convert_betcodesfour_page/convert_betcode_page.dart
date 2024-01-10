import '../../utils/navigator/page_navigator.dart';
import '../../widgets/custom_outlined_button.dart';
import '../buy_tellacoins_screen/buy_tellacoins_screen.dart';
import '../convert_betcodesfour_page/widgets/singleconversion3_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_drop_down.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_icon_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';



class ConvertBetcodesPage extends StatefulWidget {
  const ConvertBetcodesPage({Key? key}) : super(key: key);

  @override
  ConvertBetcodesPageState createState() => ConvertBetcodesPageState();
}

// ignore_for_file: must_be_immutable
class ConvertBetcodesPageState extends State<ConvertBetcodesPage>
    with AutomaticKeepAliveClientMixin<ConvertBetcodesPage> {
  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  TextEditingController mNHController = TextEditingController();

  TextEditingController jJhEightyTwoController = TextEditingController();

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
                    SizedBox(height: 14.v),
                    _buildFrameNine(context),
                    SizedBox(height: 14.v),
                    CustomElevatedButton(
                        text: "Copy code",
                        margin: EdgeInsets.symmetric(horizontal: 20.h),
                        leftIcon: Container(
                            margin: EdgeInsets.only(right: 10.h),
                            child: CustomImageView(
                                imagePath: ImageConstant.imgContentcopy,
                                height: 24.adaptSize,
                                width: 24.adaptSize))),
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
                    _buildSingleConversion(context),

                    SizedBox(height: 17.v),


                    Text(
                        "Start converting betcodes from 200 available bookies!",
                        style: CustomTextStyles.labelLargeBlack900),
                    SizedBox(height: 10.v),
                    _buildBuyTellacoins(context),
                    SizedBox(height: 11.v),
                    Container(
                        height: 198.v,
                        width: 193.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 28.h, vertical: 25.v),
                        
                        child: CustomImageView(
                          fit: BoxFit.cover,
                            imagePath: ImageConstant.imgIllustrationStartup,
                            width: MediaQuery.sizeOf(context).width,
                            alignment: Alignment.bottomLeft))
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
            height: 100.v,
            width: 350.h,
            decoration: AppDecoration.fillTeal.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
                color: Color(0xFFF288763)),
            child: Stack(alignment: Alignment.topLeft, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse72,
                  height: 41.v,
                  width: 317.h,
                  color: Color(0xFFF1E654A),
                  alignment: Alignment.bottomRight),
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse82,
                  height: 40.v,
                  width: 288.h,
                  alignment: Alignment.topLeft,
                  color: Color(0xFFF1E654A)),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(12.h, 10.v, 12.h, 7.v),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Tellacoin balance:".toUpperCase(),
                                      style:
                                          CustomTextStyles.bodySmallWhiteA700),
                                  Row(children: [
                                    CustomImageView(
                                        imagePath: ImageConstant.imgSettings,
                                        height: 26.adaptSize,
                                        width: 26.adaptSize,
                                        margin: EdgeInsets.only(
                                            top: 8.v, bottom: 7.v)),
                                    Padding(
                                        padding: EdgeInsets.only(left: 6.h),
                                        child: Text("2000",
                                            style: CustomTextStyles
                                                .headlineLargeWhiteA700))
                                  ])
                                ]),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 10.v, bottom: 13.v),
                                child: CustomIconButton(
                                    height: 30.adaptSize,
                                    width: 30.adaptSize,
                                    padding: EdgeInsets.all(6.h),
                                    onTap: () {
                                      onTapBtnPlus(context);
                                    },
                                    child: CustomImageView(
                                        imagePath: ImageConstant.imgPlus)))
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
                  width: 126.h,
                  icon: Container(
                      margin: EdgeInsets.only(left: 4.h),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgIconparksoliddownone,
                          height: 16.adaptSize,
                          width: 16.adaptSize)),
                  hintText: "Convert from",
                  items: dropdownItemList,
                  onChanged: (value) {})),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgSwapHoriz,
              height: 30.adaptSize,
              width: 30.adaptSize),
          Spacer(),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 5.v),
              child: CustomDropDown(
                  width: 105.h,
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
              controller: mNHController,
              hintText: "MN627821H",
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
                  controller: jJhEightyTwoController,
                  hintText: "128JJh82",
                  hintStyle: CustomTextStyles.titleMediumGray700,
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
              return Singleconversion3ItemWidget();
            }));
  }


  Widget _buildBuyTellacoins(BuildContext context) {
    return CustomOutlinedButton(
        text: "Buy Tellacoins", margin: EdgeInsets.symmetric(horizontal: 20.h));
  }
  onTapBtnPlus(BuildContext context) {
    AppNavigator.pushAndStackPage(context, page: BuyTellacoinsScreen());
  }
}
