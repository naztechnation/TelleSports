
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_export.dart';
import '../../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_form_field.dart';

class SetUpCommunity extends StatefulWidget {
  const SetUpCommunity({super.key});

  @override
  State<SetUpCommunity> createState() => _SetUpCommunityState();
}

class _SetUpCommunityState extends State<SetUpCommunity> {
  String? _selectedOption;
  bool _isSwitched = false;

  final List<String> _options = [
    'Free to join',
    'Require permission',
    'Pay to join'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingImage(
            onTap: () {
              Navigator.pop(context);
            },
            imagePath: ImageConstant.imgArrowBack,
            margin: EdgeInsets.only(
              left: 20.h,
               
            ),
          ),
          centerTitle: true,
          title: AppbarSubtitle(
            text: "Set up your community",
             
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Community type',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _options.map((option) {
                                    return Row(
                                      children: [
                                        Radio<String>(
                                          value: option,
                                          activeColor: Colors.blue,
                                          groupValue: _selectedOption,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedOption = value;
                                            });
                                          },
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedOption = option;
                                            });
                                          },
                                          child: Text(
                                            option,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                     if(_selectedOption.toString().toLowerCase() == 'Pay to join'.toLowerCase())   Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
                              padding: EdgeInsets.all(10),
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
                                child: _buildTextField(context),
                                ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Hide member count',
                                  style: GoogleFonts.getFont(
                                    'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF1F1C21),
                                  ),
                                ),
                                Transform.scale(
                                  scale: 0.75,
                                  child: CupertinoSwitch(
                                    value: _isSwitched,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _isSwitched = value;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF3C91E5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomElevatedButton(
                            text: "Save and continue",
                            title: "Creating community...",
                            buttonStyle: CustomButtonStyles.fillBlue,
                            onPressed: () async {
                              // AppNavigator.pushAndStackPage(context,
                              //           page: SetUpCommunity());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

   Widget _buildTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Set your price",
          style: TextStyle(
            color: appTheme.gray900,
            fontSize: 14.fSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.v),
        CustomTextFormField(
          controller: TextEditingController(),
          hintText: "₦",
          textInputAction: TextInputAction.next,
        ),
      
      ],
    );
  }
}
