import 'package:flutter/material.dart';
import 'package:tellesports/res/app_colors.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumDMSansTeal900 =>
      theme.textTheme.bodyMedium!.dMSans.copyWith(
        color: appTheme.teal900,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumDMSansWhiteA700 =>
      theme.textTheme.bodyMedium!.dMSans.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallBluegray900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 9.fSize,
      );
  static get bodySmallBluegray900_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray900,
      );
  static get bodySmallGray600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
      );
  static get bodySmallInterOnPrimaryContainer =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallOnPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get bodySmallWhiteA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
      );
  // Headline text style
  static get headlineLargeBlue400 => theme.textTheme.headlineLarge!.copyWith(
        color: Color(0xFF183A5C),
      );
  static get headlineLargeInterTeal900 =>
      theme.textTheme.headlineLarge!.inter.copyWith(
        color: appTheme.teal900,
        fontWeight: FontWeight.w700,
      );
  static get headlineLargeInterWhiteA700 =>
      theme.textTheme.headlineLarge!.inter.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get headlineLargePrimary => theme.textTheme.headlineLarge!.copyWith(
        color: AppColors.darkPrimary,
      );
  static get headlineLargeRed400 => theme.textTheme.headlineLarge!.copyWith(
        color: Color(0xFF672929),
      );
  static get headlineLargeWhiteA700 => theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  // Label text style
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
      );
  static get labelLargeBlue400 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blue400,
      );
  static get labelLargeBluegray700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray700,
      );
  static get labelLargeBluegray900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray900,
      );
  static get labelLargeGray50001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray50001,
      );
  static get labelLargeGray600 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray600,
      );
  static get labelLargeGray700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray700,
      );
  static get labelLargeInter => theme.textTheme.labelLarge!.inter.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get labelLargeInterGray500 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.gray500,
      );
  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargeRed400 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.red400,
      );
  static get labelMediumBlack900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.black900,
      );
  static get labelMediumBluegray900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blueGray900,
      );
  static get labelMediumGray600 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.gray600,
      );
  static get labelMediumGray700 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.gray700,
      );
  static get labelMediumRed600 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.red600,
      );
  static get labelMediumWhiteA700 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  // Title text style
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumBlack900Bold => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray700,
        fontSize: 17.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumBlack900_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBlue300 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blue300,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumBlue400 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blue400,
      );
  static get titleMediumBluegray100 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray100,
      );
  static get titleMediumBluegray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumGray700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray700,
      );
  static get titleMediumGray800 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray800,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleMediumOnPrimaryBold => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumOnPrimaryBold18 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumOnPrimary_1 => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleMediumRed300 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.red300,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumTeal400 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.teal400,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallBlue400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blue400,
      );
  static get titleSmallBlue400_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blue400,
      );
  static get titleSmallBlue800 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blue800,
      );
  static get titleSmallBluegray400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray400,
      );
  static get titleSmallBluegray900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
        
      );
  static get titleSmallBluegray900Bold => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallBluegray900_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
      );
  static get titleSmallGray400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray400,
      );
  static get titleSmallGray50001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray50001,
      );
  static get titleSmallGray600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray600,
      );
  static get titleSmallInterWhiteA700 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallPoppinsBlue400 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.blue400,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallPrimary_1 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallRed600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.red600,
      );
  static get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
      );
}

extension on TextStyle {
  TextStyle get dMSans {
    return copyWith(
      fontFamily: 'DM Sans',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
