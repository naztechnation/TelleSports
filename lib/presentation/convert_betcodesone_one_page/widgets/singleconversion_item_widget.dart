import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

// ignore: must_be_immutable
class SingleconversionItemWidget extends StatelessWidget {
  const SingleconversionItemWidget({Key? key})
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
                "Sporty Bet".toUpperCase(),
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(height: 3.v),
              Text(
                "M12MM678",
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
                  "NairaBet".toUpperCase(),
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 3.v),
              Text(
                "M12MM678",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
