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
class PredictionContainer extends StatefulWidget {
  final PredictMatchListData predictedInfo;
  final Function(double value)  onTap;

  const PredictionContainer({Key? key, required this.predictedInfo, required this.onTap})
      : super(
          key: key,
        );

  @override
  State<PredictionContainer> createState() => _PredictionContainerState();
}

class _PredictionContainerState extends State<PredictionContainer> {

  double initialValue   = 1;

  
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
                        initialRating: double.tryParse(widget.predictedInfo.currentRating.toString()) ?? 0.0,
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
                       initialValue = rating;
                      },
                    ),
                  ],
                ),
                btnText: 'Submit',
                onPressed: () async {
                  Navigator.pop(context);
                  widget.onTap(initialValue);
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
                      "Rated: ${approximateToDecimalPlace(double.tryParse(widget.predictedInfo.currentRating ?? '0.0') ?? 0.0, 1)}/5",
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
                  AppUtils.formatComplexDate(dateTime: widget.predictedInfo.createdAt.toString()),
                  style: CustomTextStyles.labelMediumBlack900,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Column(
              children: [
                SizedBox(
                  height: 95.v,
                  width: MediaQuery.sizeOf(context).width * 0.73,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.predictedInfo.league.toString().toUpperCase(),
                            style: CustomTextStyles.bodySmallBluegray900_1,
                          ),
                        ),
                      ),
                      
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.v),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if(widget.predictedInfo.homeImage == null || 
                              widget.predictedInfo.homeImage == 'null' || 
                              widget.predictedInfo.homeImage == '')...[
                                CustomImageView(
                                
                                imagePath: AppImages.football,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              ]else...[
                                CustomImageView(
                                imagePath: widget.predictedInfo.homeImage ?? '',
                                placeHolder: AppImages.football,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              ],
                              SizedBox(height: 2.v),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  widget.predictedInfo.homeTeam.toString(),
                                  style: CustomTextStyles.labelLargeBluegray900,
                                ),
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
                          padding: EdgeInsets.only(bottom: 8.v),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                               if(widget.predictedInfo.homeImage == null ||
                                widget.predictedInfo.homeImage == 'null' 
                               || widget.predictedInfo.homeImage == '')...[
                                CustomImageView(
                                
                                imagePath: AppImages.football,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              ]else...[
                                CustomImageView(
                                imagePath: widget.predictedInfo.homeImage  ?? '',
                                placeHolder: AppImages.football,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              ],
                              SizedBox(height: 2.v),

                              SizedBox(
                                width:100,
                                child: Center(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    widget.predictedInfo.awayTeam.toString(),
                                    style: CustomTextStyles.labelLargeBluegray900,
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.v),

                               Text(
                              "(Away)".toUpperCase(),
                              style: CustomTextStyles.bodySmallBluegray900,
                            ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 7.v),
                              child: Text(
                                "${widget.predictedInfo.homeScore.toString()}" "-" "${widget.predictedInfo.awayScore.toString()}",
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                           
                          ],
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
                              widget.predictedInfo.predictedWinner.toString(),
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
                                widget.predictedInfo.odds.toString(),
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
            const SizedBox(height: 12,),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left:4.0),
                child: Text(
                                  'By: ${widget.predictedInfo.user?.username.toString()}',
                                  style: theme.textTheme.labelLarge,
                                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String approximateToDecimalPlace(double number, int decimalPlaces) {
  return number.toStringAsFixed(decimalPlaces);
}
}
