import 'package:tellesports/utils/navigator/page_navigator.dart';

import '../community_chat_screen/community_chat_screen.dart';
import '../community_one_page/widgets/communitypagecomponent2_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

class CommunityListPage extends StatefulWidget {
  const CommunityListPage({Key? key}) : super(key: key);

  @override
  CommunityOnePageState createState() => CommunityOnePageState();
}

// ignore_for_file: must_be_immutable
class CommunityOnePageState extends State<CommunityListPage>
    with AutomaticKeepAliveClientMixin<CommunityListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: mediaQueryData.size.width,
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(height: 12.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(children: [
                        CustomTextFormField(
                            controller: searchController,
                            hintText: "Search for communities or users",
                            hintStyle: CustomTextStyles.titleSmallGray400,
                            textInputAction: TextInputAction.done,
                            prefix: Container(
                                margin:
                                    EdgeInsets.fromLTRB(20.h, 5.v, 9.h, 5.v),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgSearchGray400,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize)),
                            prefixConstraints: BoxConstraints(maxHeight: 34.v),
                            contentPadding: EdgeInsets.only(
                                top: 7.v, right: 30.h, bottom: 7.v),
                            borderDecoration: TextFormFieldStyleHelper.fillGray,
                            filled: true,
                            fillColor: appTheme.gray100),
                        SizedBox(height: 22.v),
                                                           _buildCommunityPageComponent(context)

                      ]))
                ])))));
  }

  

  Widget _buildCommunityPageComponent(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 1.v);
            },
            itemCount: 9,
            itemBuilder: (context, index) {
              return Communitypagecomponent2ItemWidget(
                  onTapCommunityPageComponent: () {
                onTapCommunityPageComponent(context);
              });
            }));
  }

 

 

  onTapCommunityPageComponent(BuildContext context) {
    AppNavigator.pushAndStackPage(context, page: CommunityChatScreen());
  }
}
