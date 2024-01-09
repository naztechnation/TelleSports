import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/community_tab_container_page/community_tab_container_page.dart';
import 'package:tellesports/presentation/convert_betcodesone_tab_container_page/convert_betcodesone_tab_container_page.dart';
import 'package:tellesports/presentation/predictions_page/predictions_page.dart';
import 'package:tellesports/presentation/predictions_two_page/predictions_two_page.dart';
import 'package:tellesports/widgets/custom_bottom_bar.dart';


// ignore_for_file: must_be_immutable
class ConvertBetcodesoneContainerScreen extends StatelessWidget {
  ConvertBetcodesoneContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.convertBetcodesoneTabContainerPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            // bottomNavigationBar: _buildBottomBar(context)
           )
            );
  }

  // Widget _buildBottomBar(BuildContext context) {
  //   return CustomBottomBar(onChanged: (BottomBarEnum type) {
  //     Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
  //   });
  // }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Convert:
        return AppRoutes.convertBetcodesoneTabContainerPage;
      case BottomBarEnum.Community:
        return AppRoutes.communityTabContainerPage;
      case BottomBarEnum.Predictions:
        return AppRoutes.predictionsTwoPage;
      case BottomBarEnum.Profile:
        return AppRoutes.predictionsPage;
      default:
        return "/";
    }
  }

  
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.convertBetcodesoneTabContainerPage:
        return ConvertBetcodesoneTabContainerPage();
      case AppRoutes.communityTabContainerPage:
        return CommunityTabContainerPage();
      case AppRoutes.predictionsTwoPage:
        return PredictionsTwoPage();
      case AppRoutes.predictionsPage:
        return PredictionsPage();
      default:
        return Container();
    }
  }
}
