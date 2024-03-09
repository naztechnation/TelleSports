
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
 
 

import 'package:provider/provider.dart';
 
import '../../provider/auth_provider.dart' as pro;
import 'request_delete_info.dart';


class RequestedUsersPage extends StatelessWidget {
  const RequestedUsersPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final groupInfo = Provider.of<pro.AuthProviders>(context, listen: true);


    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, groupInfo.requestedMembers.length.toString()),
        body: Padding(
          padding: EdgeInsets.only(
            left: 28.h,
            top: 11.v,
            right: 28.h,
          ),
          child: (groupInfo.requestedMembers.isEmpty) ? Center(child: Text('You dont have any pendinng requests')): ListView.separated(
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
            itemCount: groupInfo.requestedMembers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                 onTap: (){
        // AppNavigator.pushAndStackPage(context, page: IndividualUserInfo(name: groupInfo.groupMembers[index].name, image: groupInfo.groupMembers[index].profilePic, bio: '', username: groupInfo.groupMembers[index].name, isGroupAdmin: index == 0, ));
      },
                child: RequestDeleteInfo(name: groupInfo.requestedMembers[index].name, bio: 'My  Bio', index: index, image: groupInfo.requestedMembers[index].profilePic, isDelete: false, userId: groupInfo.requestedMembers[index].uid,));
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
        text: "$groupNumber requests",
      ),
      styleType: Style.bgOutline,
    );
  }
}
