import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart'; 

import '../all_groups.dart';
import 'community_list_page.dart';

class CommunityTabPage extends StatefulWidget {
  const CommunityTabPage({Key? key})
      : super(
          key: key,
        );

  @override
  CommunityTabContainerPageState createState() =>
      CommunityTabContainerPageState();
}

class CommunityTabContainerPageState extends State<CommunityTabPage>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 15.v),
              _buildTopSection(context),
              
              Expanded(
                child: SizedBox(
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                       
                      CommunityListPage(),
                      AllGroupsListPage(),
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

   
  Widget _buildTopSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h,),
      decoration: AppDecoration.outlineGray,
      child: Column(
        children: [
          Text(
            "Tellasport Community",
            style: CustomTextStyles.titleMediumOnPrimaryBold18,
          ),
          SizedBox(height: 15.v),
          Container(
            height: 42.v,
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
              indicator: BoxDecoration(
                color: Color(0xFF3C91E5),
                borderRadius: BorderRadius.circular(16),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text("Your communities"),
                ),
                Tab(
                  child: Text("Explore"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
