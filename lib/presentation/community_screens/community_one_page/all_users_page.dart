import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';

import '../../../model/chat_model/user_model.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../individual_user_info.dart/individual_user_info.dart';
import 'widgets/userprofile_item_widget.dart';
 

class AllUsersPage extends StatelessWidget {
  final String adminId;
  final List<UserModel> users;
  const AllUsersPage({Key? key, required this.users, required this.adminId})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);


    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, users.length.toString()),
        body: Padding(
          padding: EdgeInsets.only(
            left: 13.h,
            top: 11.v,
            right: 14.h,
          ),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 1.v,
              );
            },
            itemCount: users.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: IndividualUserInfo(
                          name: users[index].name,
                          image: users[index].profilePic,
                          bio: users[index].bio,
                          username: users[index].name,
                          isGroupAdmin: index == 0,
                        ));
                  },
                  child: UserprofileItemWidget(
                    name: users[index].name,
                    bio: users[index].bio,
                    index: adminId == users[index].uid,
                    image: users[index].profilePic,
                  ));
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String groupNumber) {
    return CustomAppBar(
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 15.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitleTwo(
        
        text: "$groupNumber Member",
      ),
      styleType: Style.bgOutline_3,
    );
  }
}
