


import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
 
 

import 'package:provider/provider.dart';
 
import '../../provider/auth_provider.dart' as pro;
import 'request_delete_info.dart';
import 'userprofile_item_widget.dart';


class BlockedUsersPage extends StatelessWidget {
  const BlockedUsersPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final groupInfo = Provider.of<pro.AuthProviders>(context, listen: true);


    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, groupInfo.blockedMembers.length.toString()),
        body: Padding(
          padding: EdgeInsets.only(
            left: 28.h,
            top: 11.v,
            right: 28.h,
          ),
          child: (groupInfo.blockedMembers.isEmpty) ? Center(child: Text('You dont have any blocked user.')): ListView.separated(
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
            itemCount: groupInfo.blockedMembers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                 onTap: (){
      },
                child: RequestDeleteInfo(name: groupInfo.blockedMembers[index].name, bio: 'My  Bio', index: index, image: groupInfo.requestedMembers[index].profilePic, isDelete: true, userId: groupInfo.requestedMembers[index].uid,));
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
