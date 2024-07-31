import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as pro;

import '../../../core/app_export.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/modals.dart';
import '../../landing_page/landing_page.dart';
import '../provider/auth_provider.dart';

class AdvancedSettingsScreen extends ConsumerStatefulWidget {
   
  const AdvancedSettingsScreen(
      {super.key,
      });

  @override
  ConsumerState<AdvancedSettingsScreen> createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends ConsumerState<AdvancedSettingsScreen> {
  String _selectedOption = '';
  bool _isSwitched = false;

  String _selectedPaymentOption = '';
  bool isLoading = false;

  bool _dataAdded = false;


  String userId = '';
  String username= '';
  String fcmToken = '';
  String coinRate = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController priceController = TextEditingController();

  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    username = await StorageHandler.getUserName() ?? '';
    fcmToken = await StorageHandler.getUserFCM() ?? '';
    coinRate = await StorageHandler.getCoinRate() ?? '';
  }

  final List<String> _options = [
    'Free to join',
    'Require permission',
    'Pay to join'
  ];

  final List<String> _paymentOption = [
    'One time payment',
    'Monthly',
  ];

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupData = pro.Provider.of<AuthProviders>(context, listen: true);

    final user = pro.Provider.of<AccountViewModel>(context, listen: true);

     if (!_dataAdded) {
      _selectedOption = groupData.groupData?.communityType ?? '';
      _selectedPaymentOption = groupData.groupData?.paymentType ?? '';
      priceController.text = groupData.groupData?.communityPrice ?? '';
      _isSwitched = groupData.groupData?.showMemberCount ?? false;
      _dataAdded = true;
    }

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
            text: "Advanced Settings",
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _options.map((option) {
                                      return Row(
                                        children: [
                                          Radio<String>(
                                            value: option,
                                            activeColor: Colors.blue,
                                            groupValue: _selectedOption,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _selectedOption = value ?? '';
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
                          if (_selectedOption.toString().toLowerCase() ==
                              'Pay to join'.toLowerCase())
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Payment Type',
                                  style: GoogleFonts.getFont(
                                    'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF342E37),
                                  ),
                                ),
                              ),
                            ),
                          if (_selectedOption.toString().toLowerCase() ==
                              'Pay to join'.toLowerCase())
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
                                children: _paymentOption.map((option) {
                                  return Row(
                                    children: [
                                      Radio<String>(
                                        value: option,
                                        activeColor: Colors.blue,
                                        groupValue: _selectedPaymentOption,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedPaymentOption =
                                                value ?? '';
                                          });
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedPaymentOption = option;
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
                          if (_selectedOption.toString().toLowerCase() ==
                              'Pay to join'.toLowerCase())
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
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
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 32),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    scale: 0.67,
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
                              text: "Save changes",
                              title: "Updating changes...",
                              processing: isLoading,
                              buttonStyle: CustomButtonStyles.fillBlue,
                              onPressed: () async {
                                if (_selectedOption.toString().isNotEmpty) {
                                  if (_selectedOption
                                          .toString()
                                          .toLowerCase() !=
                                      'Pay to join'.toLowerCase()) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                     
                                        await groupData.updateFreeGroup(
                                              groupId: groupData.groupId,
                                            
                                            communityType: _selectedOption,
                                             
                                            showMemberCount: _isSwitched, );

                                    setState(() {
                                      isLoading = false;
                                    });

                                    user.updateIndex(1);
                                      AppNavigator.pushAndStackPage(context,
                                          page: LandingPage());
                                  } else {
                                    if (_selectedOption.toString().isNotEmpty &&
                                        _selectedPaymentOption
                                            .toString()
                                            .isNotEmpty &&
                                        priceController.text
                                            .trim()
                                            .isNotEmpty) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      
                                          await groupData.updatePaidGroup(
                                              groupId: groupData.groupId,
                                              
                                              communityType: _selectedOption,
                                              communityPrice:
                                                  priceController.text,
                                              paymentType:
                                                  _selectedPaymentOption,
                                              showMemberCount: _isSwitched,  );

                                      setState(() {
                                        isLoading = false;
                                      });

                                      user.updateIndex(1);
                                      AppNavigator.pushAndStackPage(context,
                                            page: LandingPage());
                                       
                                    } else {
                                      Modals.showToast(
                                          'Please select all choices');
                                    }
                                  }
                                } else {
                                  Modals.showToast('Please select all choices');
                                }
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
          controller: priceController,
          hintText: "NGN",
          textInputAction: TextInputAction.done,
          validator: (value) {
            return Validator.validate(value, 'Price');
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            '1 Tellacoin = NGN${coinRate}',
            style: GoogleFonts.getFont(
              'DM Sans',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF1F1C21),
            ),
          ),
        ),
      ],
    );
  }
}
