import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/extentions/custom_string_extension.dart';
import 'package:tellesports/presentation/notifications/notifications.dart';
import 'package:tellesports/presentation/view_livescoresone_page/view_livescores_page.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_circleimage.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_five.dart';
import 'package:tellesports/widgets/app_bar/appbar_title.dart';
import 'package:tellesports/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';

import '../../handlers/secure_handler.dart';
import '../../model/view_models/account_view_model.dart';
import '../convert_betcode_page/convert_betcode_page.dart'; 



// ignore_for_file: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  HomePageState createState() =>
      HomePageState();
}

class HomePageState
    extends State<HomePage>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  String username = '';
  

  getUserName() async{
    username = await StorageHandler.getUserName() ?? '';
    Future.delayed(Duration(seconds: 0), (){
      setState(() {
      
    });
    });
  }

  @override
  void initState() {
    super.initState();

    getUserName();
    
    tabviewController = TabController(length: 2, vsync: this);

    
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final user = Provider.of<AccountViewModel>(context, listen: true);


    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, user),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 30.v),
              _buildTabview(context),
              Expanded(
                child: SizedBox(
                  height: 606.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      ConvertBetcodes(),
                      ViewLivescoresPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  PreferredSizeWidget _buildAppBar(BuildContext context, var user) {
    return CustomAppBar(
      leadingWidth: 60.h,
      leading: AppbarLeadingCircleimage(
        imagePath: ImageConstant.imgNavIcons,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 5.v,
          bottom: 10.v,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 8.h,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            AppbarSubtitleFive(
              text: "welcome,".toUpperCase(),
              margin: EdgeInsets.only(right: 59.h),
            ),
            AppbarTitle(
              text: "$username. ".capitalizeFirstOfEach,
            ),
          ],
        ),
      ),
      actions: [
        Stack(
          children: [
           if(user.length != 0)...[
             Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Text(user.unReadMessages),),
            ),
           ],
            AppbarTrailingImage(
              imagePath: ImageConstant.imgNotificationsNone,
              margin: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 16.v,
              ),
              onTap: (){
                AppNavigator.pushAndStackPage(context, page: NotificationsScreen());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabview(BuildContext context) {
    return   Container(
            height: 32.v,
            width: 350.h,
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadius.circular(
                16.h,
              ),
              boxShadow: [
                BoxShadow(
                  color: appTheme.black900.withOpacity(0.06),
                  spreadRadius: 2.h,
                  blurRadius: 2.h,
                  offset: Offset(
                    0,
                    0,
                  ),
                ),
              ],
            ),
      child: TabBar(
              controller: tabviewController,
              labelPadding: EdgeInsets.zero,
              labelColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
  indicatorSize: TabBarIndicatorSize.tab,  

        indicator: BoxDecoration(
          color: Color(0XFF288763),
           
          borderRadius: BorderRadius.circular(
            16.h,
          ),
        ),
        tabs: [
          Tab(
            child: Text(
              "Convert Betcodes",
            ),
          ),
          Tab(
            child: Text(
              "View Livescores",
            ),
          ),
        ],
      ),
    );
  }
}
