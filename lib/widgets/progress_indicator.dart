import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class ProgressIndicators{

  static Widget circularProgressBar(
    
      {double? value, double strokeWidth=2.5,}) {
    return CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        backgroundColor: (Colors.white24));
  }

  static Widget linearProgressBar(BuildContext context,
      {double? value, double? minHeight}) {
    return LinearProgressIndicator(
      value: value,
      minHeight: minHeight,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.lightSecondary),
      backgroundColor: Theme.of(context).colorScheme.primary
    );
  }

}