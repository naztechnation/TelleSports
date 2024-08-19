import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart'; 

import '../../../widgets/modals.dart';
import '../all_groups.dart';
import '../widgets/create_community.dart';
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

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  tabviewController.addListener(_handleTabChange);
  Future.delayed(Duration(seconds: 2), (() {
      setState(() {
        isLoading = false;
      });
    }));
  }

  @override
  void dispose() {
    tabviewController.removeListener(_handleTabChange);
    tabviewController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {
      // Trigger rebuild to ensure UI reflects the correct tab
    });
  }
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
         bottomNavigationBar:
                    // (plan.toLowerCase() == 'Community Leader'.toLowerCase() ||
                    //         email.toLowerCase().trim() ==
                    //             'officialtellasport@gmail.com')
                    //     ?
                  isLoading  ? SizedBox.shrink() :
                         SizedBox(
                          height: (isAtLastTab()) ? 80: 140,
                           child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Column(
                                children: [
                                  buildBuyTellacoins(context),
                                  const SizedBox(height: 8,),
                                (isAtLastTab()) ? SizedBox.shrink() : buildJoinGroup(context, (){
                                 
                            goToNextTab();
                                  })
                                ],
                              ),
                            ),
                         ),
                       // : SizedBox.shrink(),
                // appBar: _buildAppBar(context,),

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

void goToNextTab() {
   
  if (tabviewController.index < tabviewController.length - 1) {
    tabviewController.animateTo(tabviewController.index + 1);
  }
}

bool isAtLastTab() {
  setState(() {
    
  });
  return tabviewController.index == tabviewController.length - 1;
}
   
  Widget _buildTopSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h,vertical: 2),
      
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
             
            ),
            child: TabBar(
              controller: tabviewController,
              labelPadding: EdgeInsets.zero,
              labelColor: Colors.white,
        dividerColor: Colors.white,

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
                  child: Text("Your Communities"),
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
