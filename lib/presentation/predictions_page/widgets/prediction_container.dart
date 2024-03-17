import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/res/app_images.dart';
import 'package:tellesports/utils/app_utils.dart';
import 'package:tellesports/widgets/image_view.dart';

import '../../../model/prediction_data/predicted_match_list.dart';
import '../../../widgets/modal_content.dart';
import '../../../widgets/modals.dart';

// ignore: must_be_immutable
class PredictionContainer extends StatelessWidget {
  final PredictMatchListData predictedInfo;

  const PredictionContainer({Key? key, required this.predictedInfo})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modals.showDialogModal(context,
            page: ModalContentScreen(
                title: 'Rate this prediction: ',
                body: Column(
                  children: [
                    Text(
                      'Current rating:',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: appTheme.gray900,
                        fontSize: 14.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal:30.0),

                      child: RatingBar.builder(
                        initialRating: double.tryParse(predictedInfo.currentRating.toString()) ?? 0.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: ImageView.asset(
                            AppImages.star,
                            height: 10,
                          ),
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    const SizedBox(height: 13,),
                    Text(
                      'Your rating:',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: appTheme.gray900,
                        fontSize: 14.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: ImageView.asset(
                          AppImages.star,
                          height: 18,
                        ),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
                btnText: 'Submit',
                onPressed: () async {
                  Navigator.pop(context);
                },
                headerColorOne: Color(0xFFFDF9ED),
                headerColorTwo: Color(0xFFFAF3DA)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 7.h,
          vertical: 14.v,
        ),
        decoration: AppDecoration.outlineTeal.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rated: ${predictedInfo.currentRating}/5",
                      style: CustomTextStyles.labelMediumBlack900,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgSignalOrange300,
                      height: 12.adaptSize,
                      width: 12.adaptSize,
                      margin: EdgeInsets.only(left: 2.h),
                    ),
                  ],
                ),
                Text(
                  AppUtils.formatComplexDate(dateTime: predictedInfo.createdAt.toString()),
                  style: CustomTextStyles.labelMediumBlack900,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 78.v,
                  width: 189.h,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          predictedInfo.league.toString().toUpperCase(),
                          style: CustomTextStyles.bodySmallBluegray900_1,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.v),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if(predictedInfo.homeImage == null || predictedInfo.homeImage == 'null' || predictedInfo.homeImage == '')...[
                                CustomImageView(
                                
                                imagePath: AppImages.football,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              ]else...[
                                CustomImageView(
                                imagePath: predictedInfo.homeImage ?? '',
                                placeHolder: AppImages.football,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              ],
                              SizedBox(height: 2.v),
                              Text(
                                predictedInfo.homeTeam.toString(),
                                style: CustomTextStyles.labelLargeBluegray900,
                              ),
                              SizedBox(height: 1.v),
                              Text(
                                "(Home)".toUpperCase(),
                                style: CustomTextStyles.bodySmallBluegray900,
                              ),
                            ],
                          ),
                        ),
                      ),
                       
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 22.v),
                          child: Column(
                            children: [
                               if(predictedInfo.homeImage == null || predictedInfo.homeImage == 'null' || predictedInfo.homeImage == '')...[
                                CustomImageView(
                                
                                imagePath: AppImages.football,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              ]else...[
                                CustomImageView(
                                imagePath: predictedInfo.homeImage ?? '',
                                placeHolder: AppImages.football,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              ],
                              Text(
                                predictedInfo.awayTeam.toString(),
                                style: CustomTextStyles.labelLargeBluegray900,
                              ),

                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 14.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 7.v),
                                child: Text(
                                  "${predictedInfo.homeScore.toString()}" "-" "${predictedInfo.awayScore.toString()}",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 38.h,
                                  top: 6.v,
                                  bottom: 7.v,
                                ),
                                child: Text(
                                  "(Away)".toUpperCase(),
                                  style: CustomTextStyles.bodySmallBluegray900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.v),
                ImageView.asset(AppImages.line),
                SizedBox(height: 15.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Predicted winner:".toUpperCase(),
                          style: CustomTextStyles.bodySmallOnPrimary,
                        ),
                        SizedBox(height: 1.v),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.h,
                            vertical: 1.v,
                          ),
                          decoration: AppDecoration.fillTeal100.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                          ),
                          child: Center(
                            child: Text(
                              predictedInfo.predictedWinner.toString(),
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 33.h),
                      child: Column(
                        children: [
                          Text(
                            "Odds:".toUpperCase(),
                            style: CustomTextStyles.bodySmallOnPrimary,
                          ),
                          SizedBox(height: 1.v),
                          Container(
                            width: 45.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.h,
                              vertical: 1.v,
                            ),
                            decoration: AppDecoration.fillTeal100.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder4,
                            ),
                            child: Center(
                              child: Text(
                                predictedInfo.odds.toString(),
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
