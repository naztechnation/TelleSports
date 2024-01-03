import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Splash screen-Onboarding",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.splashScreenOnboardingScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.onboardingOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding Three",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.onboardingThreeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding Two",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.onboardingTwoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign up",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.signUpScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign up Two",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.signUpTwoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign up One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.signUpOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Signin One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.signinOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Signin",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.signinScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Forgot password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.forgotPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Verify Account#",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.verifyAccountScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Create New Password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.createNewPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Convert BetcodesOne - Container",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.convertBetcodesoneContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "View LivescoresTwo",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.viewLivescorestwoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Buy  Tellacoins",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.buyTellacoinsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Community Chat",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.communityChatScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Community Chat condensed",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.communityChatCondensedScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Community Chat empty  state",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.communityChatEmptyStateScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Community Info One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.communityInfoOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Direct Messages condensed",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.directMessagesCondensedScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "User Info - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.userInfoTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Gift Tellacoins",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.giftTellacoinsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Community  Info",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.communityInfoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Predictions One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.predictionsOneScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
