import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

import '../../../model/matches_data/match_fixtures.dart' as fixture;

// ignore: must_be_immutable
class MatchcardItemWidget extends StatelessWidget {
 final fixture.Response match ;

  MatchcardItemWidget({
    Key? key,
    this.onTapCardMatch, required this.match,
  }) : super(
          key: key,
        );

  VoidCallback? onTapCardMatch;

  @override
  Widget build(BuildContext context) {

    var homeGoal = match.goals?.home;
  var awayGoal = match.goals?.away;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     CustomImageView(
        //       imagePath: ImageConstant.imgLeaguePremierLeague,
        //       height: 24.adaptSize,
        //       width: 24.adaptSize,
        //       radius: BorderRadius.circular(
        //         4.h,
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(
        //         left: 12.h,
        //         top: 3.v,
        //       ),
        //       child: Text(
        //         "Premier League",
        //         style: CustomTextStyles.titleMediumOnPrimaryBold,
        //       ),
        //     ),
        //     Container(
        //       // width: 65.h,
        //       margin: EdgeInsets.only(
        //         left: 8.h,
        //         top: 4.v,
        //         bottom: 3.v,
        //       ),
        //       child: Row(
        //         children: [
        //           CustomImageView(
        //             imagePath: ImageConstant.imgIcon,
        //             height: 16.adaptSize,
        //             width: 16.adaptSize,
        //             margin: EdgeInsets.only(bottom: 1.v),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(left: 4.h),
        //             child: Text(
        //               "England",
        //               style: theme.textTheme.labelLarge,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
       // SizedBox(height: 10.v),
        GestureDetector(
          onTap:  onTapCardMatch,
          child: Column(
            children: [
              Container(
                decoration: AppDecoration.fillRed.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 48.h,
                            padding: EdgeInsets.symmetric(vertical: 6.v),
                            decoration: AppDecoration.fillDeepOrange,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 0.v,
                                  child: VerticalDivider(
                                    width: 3.h,
                                    thickness: 3.v,
                                    color: appTheme.red400,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.h,
                                    top: 4.v,
                                    bottom: 4.v,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                    ( match.fixture?.status?.short.toString() == 'NS' || match.fixture?.status?.short.toString() == 'CANC' || match.fixture?.status?.elapsed.toString() == 'null') ? '0':    ( match.fixture?.status?.short == 'FT' || match.fixture?.status?.short == 'PEN' || match.fixture?.status?.short == 'HT' || match.fixture?.status?.elapsed == null) ?  match.fixture?.status?.elapsed.toString() ?? '':  "${match.fixture?.status?.elapsed.toString()}’" ,
                                        style:
                                            CustomTextStyles.labelLargeRed400,
                                      ),
                                      SizedBox(height: 1.v),
                                      Text(
                                        match.fixture?.status?.short.toString() ?? '',
                                        style: theme.textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.h,
                              top: 8.v,
                              bottom: 8.v,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: match.teams?.home?.logo ?? '',
                                      //placeHolder: 'assets/images/others/ball.png',
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.h),
                                      child: Text( 
                                        match.teams?.home?.name ?? '',
                                        style: theme.textTheme.labelLarge,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.v),
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: match.teams?.away?.logo ?? '',
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                    ),
                                      SizedBox(width: 5.v),

                                    Text(
                                      match.teams?.away?.name ?? '',
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.v),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                  (homeGoal == null) ? 'NS':homeGoal.toString() ,
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                                SizedBox(height: 4.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 1.h),
                                  child: Text(
                                   (awayGoal == null) ? 'NS': awayGoal.toString(),
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                     SizedBox(width: 15.v),
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgSignal,
                    //   height: 16.adaptSize,
                    //   width: 16.adaptSize,
                    //   margin: EdgeInsets.only(
                    //     left: 29.h,
                    //     top: 18.v,
                    //     bottom: 18.v,
                    //   ),
                    // ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ],
    );
  }


   ViewMatchDetailsPage(BuildContext context) {
  }
}
