import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tellesports/widgets/modals.dart';

import '../../blocs/prediction/prediction.dart';
import '../../core/constants/enums.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/prediction_repo/predict_repository_impl.dart';
import '../../utils/validator.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/modal_content.dart';
import '../community_screens/provider/auth_provider.dart' as pro;



class UserInfoPage extends StatelessWidget {
   final bool isGroupAdmin;
  final String memberId;
  final String memberName;
  const UserInfoPage({
    Key? key,
     required this.isGroupAdmin, required this.memberId, required this.memberName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PredictionCubit>(
      create: (BuildContext context) => PredictionCubit(
          predictRepository: PredictRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: UserInfo(isGroupAdmin: isGroupAdmin, memberId: memberId, memberName: memberName,),
    );
  }
}

class UserInfo extends StatefulWidget {
  final bool isGroupAdmin;
  final String memberId;
  final String memberName;

  const UserInfo({Key? key, required this.isGroupAdmin, required this.memberId, required this.memberName})
      : super(
          key: key,
        );

  @override
  UserInfoPageState createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfo>
    with AutomaticKeepAliveClientMixin<UserInfo> {
  TextEditingController notificationsvalueController = TextEditingController();

  final compaintController = TextEditingController();


late PredictionCubit _predictionCubit;

  
  @override
  bool get wantKeepAlive => true;

  String userId = '';

  bool isLoading = false;

  getCurrentUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    _predictionCubit = context.read<PredictionCubit>();


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
        body: BlocConsumer<PredictionCubit, PredictStates>(
              listener: (context, state) {
                if (state is ReportUserLoaded) {
                  if (state.complaint.success ?? false) {
                    Modals.showToast( 'Complaint submitted successfully',
                        messageType: MessageType.success);
                        compaintController.clear();
            
                     
                  } else {
                    Modals.showToast('Failed to submit complaint',
                        messageType: MessageType.error);
                  }
                } else if (state is PredictApiErr) {
                  if (state.message != null) {
                    Modals.showToast(state.message ?? '',
                        messageType: MessageType.error);
                  }
                } else if (state is PredictNetworkErr) {
                  if (state.message != null) {
                    Modals.showToast(state.message ?? '',
                        messageType: MessageType.error);
                  }
                }
              },
              builder: (context, state) => Container(
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
                     if(state is ReportUserLoading)...[

                     ]else...[
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
                     ] ,  
                      if (groupData.groupAdminId == userId)
                      SizedBox(height: 16.v),
                     if(isLoading)...[

                     ]else...[
                       CustomOutlinedButton(
                        text: "Report user",
                        title: 'Submitting report...',
                        loadingColour: Colors.green.shade700,
                          processing: state is ReportUserLoading,
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
                                    if(compaintController.text.isNotEmpty){
                                    _predictionCubit.sendReport(complaintType: 'user', complaint: compaintController.text, reportedUser: widget.memberName);

                                    }else{
                                      Modals.showToast('Please fill in your complaints');
                                    }
                                  },
                                  headerColorOne: Color(0xFFFDF9ED),
                                  headerColorTwo: Color(0xFFFAF3DA)));
                          },
          
                      ),
                     ]
                    ],
                  ),
                ),
              ],
            ),
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
