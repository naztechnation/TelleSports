import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/common/widgets/loader.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/community_screens/community_one_page/update_commmunity_info.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';
import 'package:tellesports/widgets/image_view.dart';

import '../../../blocs/prediction/prediction.dart';
import '../../../core/constants/enums.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/chat_model/user_model.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/prediction_repo/predict_repository_impl.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/modal_content.dart';
import '../../../widgets/modals.dart';
import '../../individual_user_info.dart/individual_user_info.dart';
import '../provider/auth_provider.dart' as pro;
import 'all_users_page.dart';

import 'widgets/blocked_users.dart';
import 'widgets/image_view.dart';
import 'widgets/requests_page.dart';
import 'widgets/userprofile_item_widget.dart';

// ignore_for_file: must_be_immutable

class CommunityInfoScreen extends StatelessWidget {
  final String profilePic;
  final String name;
  final List<String> membersUid;
  CommunityInfoScreen(
      {Key? key,
      required this.profilePic,
      required this.name,
      required this.membersUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PredictionCubit>(
      create: (BuildContext context) => PredictionCubit(
          predictRepository: PredictRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: CommunityInfo(
        profilePic: profilePic,
        name: name,
        membersUid: membersUid,
      ),
    );
  }
}

class CommunityInfo extends StatefulWidget {
  final String profilePic;
  final String name;
  final List<String> membersUid;

  CommunityInfo(
      {Key? key,
      required this.profilePic,
      required this.name,
      required this.membersUid})
      : super(key: key);

  @override
  State<CommunityInfo> createState() => _CommunityInfoState();
}

class _CommunityInfoState extends State<CommunityInfo> {
  TextEditingController vectorController = TextEditingController();

  final compaintController = TextEditingController();

  late PredictionCubit _predictionCubit;

  List<UserModel> requestItems = [];
  List<UserModel> blockedItems = [];
  List<UserModel> groupMembers = [];
  String userId = '';
  bool _dataAdded = false;

  bool isLoading = false;
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    _predictionCubit = context.read<PredictionCubit>();

    setState(() {});
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupInfo = Provider.of<pro.AuthProviders>(context, listen: true);
    final user = Provider.of<AccountViewModel>(context, listen: true);

    if (!_dataAdded) {
      // groupInfo.clearGroupInfo();

      _dataAdded = true;
    }

    requestItems = removeDuplicates(groupInfo.requestedMembers);
    blockedItems = removeDuplicates(groupInfo.blockedMembers);

    moveItemToFirst(groupInfo.groupAdminId);

    getUsers(groupInfo);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: BlocConsumer<PredictionCubit, PredictStates>(
              listener: (context, state) {
                if (state is ReportUserLoaded) {
                  if (state.complaint.success ?? false) {
                    Modals.showToast('Complaint submitted successfully',
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
              builder: (context, state) => SingleChildScrollView(
                  padding: EdgeInsets.only(top: 15.v),
                  child: Container(
                      margin: EdgeInsets.only(bottom: 5.v),
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Modals.showDialogModal(
                                          borderRadius: 12,
                                          context,
                                          page: _showFullImage(
                                              context, widget.profilePic));
                                    },
                                    child: CustomImageView(
                                        imagePath: widget.profilePic,
                                        placeHolder: ImageConstant.imgAvatar,
                                        height: 64.adaptSize,
                                        width: 64.adaptSize,
                                        radius: BorderRadius.circular(32.h)),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.h, bottom: 18.v),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(widget.name,
                                                style: TextStyle(
                                                    color: appTheme.gray900,
                                                    fontSize: 18.fSize,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            SizedBox(height: 2.v),
                                            Text(
                                                (groupInfo.groupNumber == '1')
                                                    ? "${groupInfo.groupNumber}   Member"
                                                    : "${groupInfo.groupNumber}   Members",
                                                style: TextStyle(
                                                    color: theme.colorScheme
                                                        .onPrimaryContainer,
                                                    fontSize: 14.fSize,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ]))
                                ]),
                            const SizedBox(
                              height: 12,
                            ),
                            if (groupInfo.groupAdminId == userId)
                              Column(children: [
                                Card(
                                  elevation: 0.3,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.notifications,
                                      color: Colors.blue,
                                    ),
                                    title: const Text('Mute Group'),
                                    trailing: StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('groups')
                                          .doc(groupInfo.groupId)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              snapshot) {
                                        final isGroupLocked = snapshot.data
                                                ?.get('isGroupLocked') ??
                                            false;

                                        return CupertinoSwitch(
                                            value: isGroupLocked,
                                            activeColor: Colors.blue,
                                            onChanged: (newValue) =>
                                                setState(() {
                                                  groupInfo
                                                      .updateGroupLockStatus(
                                                          groupInfo.groupId,
                                                          newValue);
                                                }));
                                      },
                                    ),
                                  ),
                                ),
                              ]),

                            SizedBox(height: 24.v),
                            _buildCommunityDescription(
                                context, groupInfo.groupDescription, groupInfo),
                            //   SizedBox(height: 24.v),
                            //  _buildShareCommunity(context, groupInfo.groupLink),
                            if (groupInfo.groupImageList.isNotEmpty)
                              SizedBox(height: 24.v),
                            if (groupInfo.groupImageList.isNotEmpty)
                              _buildMedia(context, groupInfo.groupImageList),
                            SizedBox(height: 14.v),
                            if (groupInfo.groupAdminId == userId)
                              SizedBox(height: 18.v),
                            if (groupInfo.groupAdminId == userId)
                              GestureDetector(
                                onTap: () {
                                  AppNavigator.pushAndStackPage(context,
                                      page: RequestedUsersPage(
                                        item: requestItems,
                                      ));
                                },
                                child: Card(
                                    elevation: 0.2,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Requests'),
                                          Container(
                                            width: 26.adaptSize,
                                            height: 26.adaptSize,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Center(
                                                child: Text(
                                                  "${requestItems.length}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            if (groupInfo.groupAdminId == userId)
                              SizedBox(height: 18.v),
                            if (groupInfo.groupAdminId == userId)
                              GestureDetector(
                                onTap: () {
                                  AppNavigator.pushAndStackPage(context,
                                      page:
                                          BlockedUsersPage(item: blockedItems));
                                },
                                child: Card(
                                    elevation: 0.2,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Blocked Users'),
                                          Container(
                                            width: 26.adaptSize,
                                            height: 26.adaptSize,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Center(
                                                child: Text(
                                                  "${blockedItems.length}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            // Card(
                            //   elevation: 0.4,
                            //   child: Container(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 10, vertical: 20),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Text("Chat Notifications",
                            //             style: TextStyle(
                            //                 fontSize: 14.fSize,
                            //                 fontFamily: 'DM Sans',
                            //                 fontWeight: FontWeight.w500)),
                            //         Switch.adaptive(
                            //             activeColor: Colors.blue,
                            //             inactiveThumbColor: Colors.black12,
                            //             inactiveTrackColor: Colors.grey,
                            //             value: true,
                            //             onChanged: ((value) {}))
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 24.v),
                            _buildUserProfile(context, groupInfo.groupNumber,
                                groupMembers.length, groupInfo.groupAdminId),
                            if (isLoading || state is ReportUserLoading) ...[
                              SizedBox(height: 24.v),
                              Center(
                                child: Loader(),
                              )
                            ] else ...[
                              Column(
                                children: [
                                  SizedBox(height: 30.v),
                                  CustomElevatedButton(
                                      text: "Leave community",
                                      processing: isLoading,
                                      buttonStyle: CustomButtonStyles.fillRed,
                                      onPressed: () async {
                                        if (groupInfo.groupAdminId == userId) {
                                          Modals.showToast(
                                              'You are an admin and can\'t leave the community');
                                        } else {
                                          Modals.showAlertOptionDialog(context,
                                              title: 'Exit Community',
                                              message:
                                                  'Are you sure you want to leave this community.',
                                              onTap: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await groupInfo
                                                .removeCurrentUserFromMembers(
                                                    groupInfo.groupId,
                                                    userId,
                                                    context);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          });

                                          AppNavigator.pushAndStackPage(context,
                                              page: LandingPage());
                                          user.updateIndex(0);
                                        }
                                      }),
                                  if (groupInfo.groupAdminId == userId)
                                    SizedBox(height: 16.v),
                                  if (groupInfo.groupAdminId == userId)
                                    CustomElevatedButton(
                                        text: "Delete community",
                                        processing: isLoading,
                                        buttonStyle: CustomButtonStyles.fillRed,
                                        onPressed: () async {
                                          Modals.showAlertOptionDialog(context,
                                              title: 'Delete Community',
                                              message:
                                                  'Warning: Are you sure you want to Delete this community. As  this action cannot be reversed...',
                                              onTap: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await groupInfo.deleteGroup(
                                                groupInfo.groupId, context);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            user.updateIndex(0);
                                            AppNavigator.pushAndStackPage(
                                                context,
                                                page: LandingPage());
                                          });
                                        }),
                                  SizedBox(height: 16.v),
                                  CustomOutlinedButton(
                                    text: "Report community",
                                    processing: isLoading,
                                    onPressed: () {
                                      Modals.showDialogModal(context,
                                          page: ModalContentScreen(
                                              title: 'Report this user',
                                              body: Column(
                                                children: [
                                                  _buildComplaintField(context)
                                                ],
                                              ),
                                              btnText: 'Submit',
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                if (compaintController
                                                    .text.isNotEmpty) {
                                                  _predictionCubit.sendReport(
                                                      complaintType: 'group',
                                                      complaint:
                                                          compaintController
                                                              .text,
                                                      reportedUser:
                                                          groupInfo.groupName,
                                                      groupId:
                                                          groupInfo.groupId,
                                                      groupLeaderName:
                                                          groupMembers[0].name,
                                                      groupName:
                                                          groupInfo.groupName);
                                                } else {
                                                  Modals.showToast(
                                                      'Please fill in your complaints');
                                                }
                                              },
                                              headerColorOne: Color(0xFFFDF9ED),
                                              headerColorTwo:
                                                  Color(0xFFFAF3DA)));
                                    },
                                  ),
                                  SizedBox(height: 30.v)
                                ],
                              )
                            ]
                          ]))),
            )));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Community Info",
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }

  Widget _buildCommunityDescription(
      BuildContext context, String desc, var group) {
    return Card(
      elevation: 0.4,
      child: Container(
          padding: EdgeInsets.all(8.h),
          // decoration: AppDecoration.outlineBlackF
          //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.v),
                Text("Community Description",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 6.v),
                Container(
                    width: 312.h,
                    margin: EdgeInsets.only(right: 21.h),
                    child: Text(desc,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: appTheme.gray900,
                            fontSize: 14.fSize,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500))),
                const SizedBox(
                  height: 20,
                ),
                if (group.groupAdminId == userId)
                  CustomElevatedButton(
                    text: 'Edit Info',
                    onPressed: () {
                      AppNavigator.pushAndStackPage(context,
                          page: UpdateCommunityInfoScreen(
                              widget.profilePic, group.groupId));
                    },
                  )
              ])),
    );
  }

  Widget _buildShareCommunity(BuildContext context, String groupLink) {
    return GestureDetector(
        onTap: () {
          // onTapShareCommunity(context);
        },
        child: Card(
          elevation: 0.4,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.v),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Share Community",
                        style: TextStyle(
                            fontSize: 16.fSize,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 6.v),
                    Row(children: [
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 3.v, bottom: 1.v),
                            child: Text("$groupLink",
                                style: TextStyle(
                                    color: appTheme.blue300,
                                    fontSize: 14.fSize,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500))),
                      ),
                      CustomImageView(
                          imagePath: ImageConstant.imgShare,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          margin: EdgeInsets.only(left: 48.h))
                    ])
                  ])),
        ));
  }

  Widget _buildMedia(BuildContext context, List<String> images) {
    return Card(
      elevation: 0.4,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 11.v),
          // decoration: AppDecoration.outlineBlackF
          //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Media",
                    style: TextStyle(
                        fontSize: 16.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 8.v),
                Stack(
                  children: [
                    SizedBox(
                      height: 75,
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.builder(
                          itemCount: images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Modals.showDialogModal(
                                    borderRadius: 12,
                                    context,
                                    page:
                                        _showFullImage(context, images[index]));
                              },
                              child: CustomImageView(
                                  imagePath: images[index],
                                  height: 75.adaptSize,
                                  width: 75.adaptSize),
                            );
                          })),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          AppNavigator.pushAndStackPage(context,
                              page: ShowAllImageView());
                        },
                        child: Container(
                          height: 75,
                          width: 35,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgArrowRight,
                                height: 30.adaptSize,
                                width: 30.adaptSize,
                                margin: EdgeInsets.symmetric(vertical: 18.v)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ])),
    );
  }

  Widget _buildUserProfile(BuildContext context, String groupNumber,
      int memberLength, String adminId) {
    return Card(
      elevation: 0.4,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 11.v),
          // decoration: AppDecoration.outlineBlackF
          //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    (groupNumber == '1')
                        ? "${groupNumber} Member"
                        : "${groupNumber} Members",
                    style: TextStyle(
                        fontSize: 16.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 8.v),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (memberLength <= 10) ? memberLength : 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          AppNavigator.pushAndStackPage(context,
                              page: IndividualUserInfo(
                                name: groupMembers[index].name,
                                image: groupMembers[index].profilePic,
                                bio: groupMembers[index].bio,
                                username: groupMembers[index].name,
                                isGroupAdmin:
                                    adminId == groupMembers[index].uid,
                                memberId: groupMembers[index].uid,
                              ));
                        },
                        child: UserprofileItemWidget(
                          name: groupMembers[index].name,
                          bio: groupMembers[index].bio,
                          index: adminId == groupMembers[index].uid,
                          image: groupMembers[index].profilePic,
                        ),
                      );
                    }),
                SizedBox(height: 12.v),
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: AllUsersPage(
                          users: groupMembers,
                          adminId: adminId,
                        ));
                  },
                  child: Text("see all >",
                      style: TextStyle(
                          fontSize: 16.fSize,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500)),
                ),
              ])),
    );
  }

  _showFullImage(BuildContext context, String imageUrl) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          height: MediaQuery.sizeOf(context).height * 0.60,
          child: Center(
            child: ImageView.network(
              height: MediaQuery.sizeOf(context).height * 0.60,
              imageUrl,
              placeholder: 'assets/images/image_not_found.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  List<UserModel> removeDuplicates(List<UserModel> items) {
    Map<int, UserModel> uniqueItems = {};

    items.forEach((item) {
      if (items.isNotEmpty || items != []) {
        uniqueItems[int.tryParse(item.uid)!] = item;
      }
    });

    return uniqueItems.values.toList();
  }

  void moveItemToFirst(String adminId) {
    int index = groupMembers.indexWhere((item) => item.uid == adminId);
    if (index != -1) {
      var item = groupMembers.removeAt(index);
      groupMembers.insert(0, item);
      setState(() {});
    }
  }

  getUsers(groupInfo) async {
    groupMembers = await groupInfo.fetchUsers(widget.membersUid);

    setState(() {});
  }

  Widget _buildComplaintField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Report Community *", style: theme.textTheme.titleSmall),
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
