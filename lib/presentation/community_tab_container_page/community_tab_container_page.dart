import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/community_one_page/community_one_page.dart';
import 'package:tellesports/presentation/community_two_page/community_two_page.dart';

// ignore_for_file: must_be_immutable
class CommunityTabContainerPage extends StatefulWidget {
  const CommunityTabContainerPage({Key? key})
      : super(
          key: key,
        );

  @override
  CommunityTabContainerPageState createState() =>
      CommunityTabContainerPageState();
}

class CommunityTabContainerPageState extends State<CommunityTabContainerPage>
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
         // decoration: AppDecoration.fillWhiteA,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 51.v),
              _buildTopSection(context),
              Expanded(
                child: SizedBox(
                  height: 631.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      CommunityTwoPage(),
                      CommunityOnePage(),
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
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      decoration: AppDecoration.outlineGray,
      child: Column(
        children: [
          Text(
            "Tellasport Community",
            style: CustomTextStyles.titleMediumOnPrimaryBold18,
          ),
          SizedBox(height: 13.v),
          Container(
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
              indicator: BoxDecoration(
                color: Color(0XFF288763),
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
