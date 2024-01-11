import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_title.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_drop_down.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/modal_content.dart';

class TransferCoin extends StatelessWidget {
  TransferCoin({Key? key})
      : super(
          key: key,
        );

  List<String> dropdownItemList = [
    "Uba",
    "Access Bank",
    "Eco",
  ];

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 19.v,
              ),
              child: Column(
                children: [
                  Text(
                    "Amount: 500 Tellacoins",
                    style: TextStyle(
                      color: appTheme.teal900,
                      fontSize: 16.fSize,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.v),
                  Text(
                    "Value: N10,000",
                    style: TextStyle(
                      color: appTheme.teal900,
                      fontSize: 18.fSize,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 13.v),
                  _buildTextFieldBank(context),
                  SizedBox(height: 15.v),
                  _buildTextFieldMobileNo(context),
                  SizedBox(height: 15.v),
                  _buildTextFieldName(context),
                  SizedBox(height: 30.v),
                  CustomElevatedButton(
                    text: "Withdraw Tellacoins",
                    onPressed: () => Modals.showDialogModal(context, page: ModalContentScreen(title: 'Processing...', body: 'Your withdrawal is being processed. Your account will be credited within 24 hours.', btnText: 'Done', headerColorOne: Color(0xFFFDF9ED), headerColorTwo: Color(0xFFFAF3DA),)),
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
         onTap: (){
          Navigator.pop(context);
        },
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Withdraw Tellacoins",
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }

   
  Widget _buildTextFieldBank(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bank",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3.v),
        CustomDropDown(
          suffix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 12.v, 8.h, 12.v),
            child: CustomImageView(
               imagePath: ImageConstant.imgArrowdropdown,
               color: Colors.green,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          
          ),
           icon: SizedBox.shrink(),
          hintText: "Zenith Bank",
          items: dropdownItemList,
          onChanged: (value) {},
        ),
      ],
    );
  }

   
  Widget _buildTextFieldMobileNo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter bank account number",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3.v),
        CustomTextFormField(
          controller: mobileNoController,
          hintText: "2208609977",
          textInputType: TextInputType.phone,
        ),
      ],
    );
  }

   
  Widget _buildTextFieldName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account name",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3.v),
        CustomTextFormField(
          controller: nameController,
          hintText: "Oghenerukevwe Aror",
          textInputAction: TextInputAction.done,
          // borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL8,
          filled: true,
          fillColor: appTheme.gray100,
        ),
      ],
    );
  }
}
