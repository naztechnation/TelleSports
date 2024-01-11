import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/convert_betcodesfour_page/convert_betcode_page.dart';
import 'package:tellesports/presentation/view_livescoresone_page/view_livescores_page.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_circleimage.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_five.dart';
import 'package:tellesports/widgets/app_bar/appbar_title.dart';
import 'package:tellesports/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class ConvertBetcodesoneTabContainerPage extends StatefulWidget {
  const ConvertBetcodesoneTabContainerPage({Key? key})
      : super(
          key: key,
        );

  @override
  ConvertBetcodesoneTabContainerPageState createState() =>
      ConvertBetcodesoneTabContainerPageState();
}

class ConvertBetcodesoneTabContainerPageState
    extends State<ConvertBetcodesoneTabContainerPage>
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
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 12.v),
              _buildTabview(context),
              Expanded(
                child: SizedBox(
                  height: 606.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      ConvertBetcodesPage(),
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

 
  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
        padding: EdgeInsets.only(left: 8.h),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            AppbarSubtitleFive(
              text: "welcome,".toUpperCase(),
              margin: EdgeInsets.only(right: 59.h),
            ),
            AppbarTitle(
              text: "John Doe. ",
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotificationsNone,
          margin: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 16.v,
          ),
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
