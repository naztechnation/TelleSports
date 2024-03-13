
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
 
import '../../../utils/navigator/page_navigator.dart';
import '../../individual_user_info.dart/individual_user_info.dart';
import 'widgets/userprofile_item_widget.dart';

import 'package:provider/provider.dart';
import '../provider/auth_provider.dart' as pro;


class AllUsersPage extends StatelessWidget {
  const AllUsersPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final groupInfo = Provider.of<pro.AuthProviders>(context, listen: true);


    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, groupInfo.groupNumber),
        body: Padding(
          padding: EdgeInsets.only(
            left: 28.h,
            top: 11.v,
            right: 28.h,
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
            itemCount: groupInfo.groupMembers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                 onTap: (){
        AppNavigator.pushAndStackPage(context, page: IndividualUserInfo(name: groupInfo.groupMembers[index].name, image: groupInfo.groupMembers[index].profilePic, bio: groupInfo.groupMembers[index].bio, username: groupInfo.groupMembers[index].name, isGroupAdmin: index == 0, ));
      },
                child: UserprofileItemWidget(name: groupInfo.groupMembers[index].name, bio: groupInfo.groupMembers[index].bio, index: index, image: groupInfo.groupMembers[index].profilePic,));
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
        onTap: (){
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
      title: AppbarSubtitleOne(
        text: "$groupNumber member",
      ),
    );
  }
}
