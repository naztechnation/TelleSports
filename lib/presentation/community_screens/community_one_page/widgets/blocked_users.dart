


import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
 
 

import 'package:provider/provider.dart';
 
import '../../../../model/chat_model/user_model.dart';
import '../../provider/auth_provider.dart' as pro;
import 'request_delete_info.dart'; 


class BlockedUsersPage extends StatelessWidget {
  final List<UserModel> item;
  const BlockedUsersPage({Key? key, required this.item})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);



    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, item.length.toString()),
        body: Padding(
          padding: EdgeInsets.only(
            left: 28.h,
            top: 11.v,
            right: 28.h,
          ),
          child: (item.isEmpty) ? Center(child: Text('You dont have any blocked user.')): ListView.separated(
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
            itemCount: item.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                 onTap: (){
      },
                child: RequestDeleteInfo(name: item[index].name, bio: item[index].bio, index: index, image: item[index].profilePic, isDelete: true, userId: item[index].uid,));
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
