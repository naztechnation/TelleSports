import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

import '../../../model/auth_model/converter_history.dart';

// ignore: must_be_immutable
class SingleconversionHistory extends StatelessWidget {

 final ConverterHistoryData convertionHistoties;

  const SingleconversionHistory({Key? key,required this.convertionHistoties})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${convertionHistoties.convertedFrom?? ''}".toUpperCase(),
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(height: 3.v),
              Text(
                "${convertionHistoties.sourceCode?? ''}",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          CustomImageView(
            imagePath: ImageConstant.imgGgSwap,
            height: 32.adaptSize,
            width: 32.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 3.v),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${convertionHistoties.convertedTo?? ''}".toUpperCase(),
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 3.v),
              Text(
                "${convertionHistoties.destinationCode?? ''}",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
