import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tellesports/widgets/modals.dart';

import '../../utils/validator.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/modal_content.dart';
import '../community_screens/provider/auth_provider.dart' as pro;

// ignore_for_file: must_be_immutable
class UserInfoPage extends StatefulWidget {
  final bool isGroupAdmin;
  final String memberId;
  const UserInfoPage({Key? key, required this.isGroupAdmin, required this.memberId})
      : super(
          key: key,
        );

  @override
  UserInfoPageState createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage>
    with AutomaticKeepAliveClientMixin<UserInfoPage> {
  TextEditingController notificationsvalueController = TextEditingController();

  final compaintController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  String userId = '';

  bool isLoading = false;

  getCurrentUserId() async {
    userId = await StorageHandler.getUserId() ?? '';

    setState(() {});
  }

  @override
  void initState() {
    getCurrentUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final groupData =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              SizedBox(height: 36.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    if (widget.isGroupAdmin)
                    SizedBox(height: 24.v),
                    if (groupData.groupAdminId == userId)
                      CustomElevatedButton(
                        text: "Block",
                        processing: isLoading,
                        buttonStyle: CustomButtonStyles.fillRedTL8,
                        onPressed: () async {
                          if (widget.isGroupAdmin) {
                            Modals.showToast('Oppss you can\'t block yourself');
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            await groupData.removeCurrentUserFromMembers(groupData.groupId, widget.memberId, context);
                            await groupData.addUserToBlockedMembers(
                                groupData.groupId, widget.memberId, context);
                            setState(() {
                              isLoading = false;
                            });

                            AppNavigator.pushAndStackPage(context, page: LandingPage());
                          }
                        },
                      ),
                    if (groupData.groupAdminId == userId)
                    SizedBox(height: 16.v),
                    CustomOutlinedButton(
                      text: "Report user",
                        processing: isLoading,
                        onPressed: () {
                          
                           Modals.showDialogModal(context,
                            page: ModalContentScreen(
                                title: 'Report this user',
                                body: Column(
                                  children: [_buildComplaintField(context)],
                                ),
                                btnText: 'Submit',
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                headerColorOne: Color(0xFFFDF9ED),
                                headerColorTwo: Color(0xFFFAF3DA)));
                        },

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Report *", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: compaintController,
              hintText: "Enter your report here",
              hintStyle: CustomTextStyles.titleSmallGray600,
              maxLines: 5,
              textInputType: TextInputType.name,
              validator: (value) {
                return Validator.validate(value, 'Report');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }
}
