import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue300,
      );
  static BoxDecoration get fillBlue50 => BoxDecoration(
        color: appTheme.blue50,
      );
  static BoxDecoration get fillBlue5001 => BoxDecoration(
        color: appTheme.blue5001,
      );
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray50,
      );
  static BoxDecoration get fillBluegray800 => BoxDecoration(
        color: appTheme.blueGray800,
      );
  static BoxDecoration get fillDeepOrange => BoxDecoration(
        color: appTheme.deepOrange100,
      );
  static BoxDecoration get fillDeeporange50 => BoxDecoration(
        color: appTheme.deepOrange50,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray100,
      );
  static BoxDecoration get fillLime => BoxDecoration(
        color: appTheme.lime50,
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red50,
      );
  static BoxDecoration get fillRed400 => BoxDecoration(
        color: appTheme.red400,
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal400,
      );
  static BoxDecoration get fillTeal100 => BoxDecoration(
        color: appTheme.teal100,
      );
  static BoxDecoration get fillTeal50 => BoxDecoration(
        color: appTheme.teal50,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.08),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: appTheme.whiteA700,
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
      );
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        color: appTheme.whiteA700,
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
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray400,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray100 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.gray100,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.08),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineGray400 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.gray400,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray4001 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.gray400,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray600 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray600,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineTeal => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.teal100,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.08),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get circleBorder20 => BorderRadius.circular(
        20.h,
      );
  static BorderRadius get circleBorder24 => BorderRadius.circular(
        24.h,
      );
  static BorderRadius get circleBorder30 => BorderRadius.circular(
        30.h,
      );
  static BorderRadius get circleBorder50 => BorderRadius.circular(
        50.h,
      );

  // Custom borders
  static BorderRadius get customBorderTL10 => BorderRadius.only(
        topLeft: Radius.circular(10.h),
        topRight: Radius.circular(10.h),
        bottomLeft: Radius.circular(2.h),
        bottomRight: Radius.circular(10.h),
      );
  static BorderRadius get customBorderTL101 => BorderRadius.only(
        topLeft: Radius.circular(10.h),
        topRight: Radius.circular(10.h),
        bottomLeft: Radius.circular(10.h),
        bottomRight: Radius.circular(2.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.
    
// For Flutter SDK Version 3.7.2 or greater.
    
double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
    