import 'package:flutter/material.dart';
import '../../core/app_export.dart';

String _appTheme = "primary";

class ThemeHelper {
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  PrimaryColors _getThemeColors() {
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  ThemeData _getThemeData() {
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.whiteA700,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: appTheme.gray700,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.blueGray100,
      ),
    );
  }

  PrimaryColors themeColor() => _getThemeColors();

  ThemeData themeData() => _getThemeData();
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.gray700,
          fontSize: 11.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w300,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 32.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w900,
        ),
        headlineSmall: TextStyle(
          color: appTheme.teal900,
          fontSize: 24.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 12.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 10.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w900,
        ),
        titleMedium: TextStyle(
          color: colorScheme.primary,
          fontSize: 16.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 14.fSize,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
      );
}

class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    primary: Color(0XFF288763),

    onPrimary: Color(0XFF1F1C21),
    onPrimaryContainer: Color(0XFFEDA0A0),
  );
}

class PrimaryColors {
  Color get amber200 => Color(0XFFF1DC91);

  Color get black900 => Color(0XFF000000);

  Color get blue200 => Color(0XFF8ABDEF);
  Color get blue300 => Color(0XFF63A7EA);
  Color get blue400 => Color(0XFF3C91E5);
  Color get blue50 => Color(0XFFD8E9FA);
  Color get blue5001 => Color(0XFFECF4FC);
  Color get blue800 => Color(0XFF3074B7);

  // BlueGray
  Color get blueGray100 => Color(0XFFD6D5D7);
  Color get blueGray400 => Color(0XFF8E8E93);
  Color get blueGray50 => Color(0XFFEBF6F2);
  Color get blueGray700 => Color(0XFF475569);
  Color get blueGray800 => Color(0XFF183A5C);
  Color get blueGray900 => Color(0XFF342E37);

  // DeepOrange
  Color get deepOrange100 => Color(0XFFF3BFBF);
  Color get deepOrange50 => Color(0XFFF9DFDF);

  // Gray
  Color get gray100 => Color(0XFFF2F1F2);
  Color get gray400 => Color(0XFFC2C0C3);
  Color get gray500 => Color(0XFF9B9B9B);
  Color get gray50001 => Color(0XFFAEABAF);
  Color get gray600 => Color(0XFF858287);
  Color get gray700 => Color(0XFF5D585F);
  Color get gray800 => Color(0XFF672929);
  Color get gray900 => Color(0XFF092413);

  // Lime
  Color get lime50 => Color(0XFFFDF9ED);

  // Orange
  Color get orange300 => Color(0XFFE8C547);

  // Red
  Color get red300 => Color(0XFFE78080);
  Color get red400 => Color(0XFFE06060);
  Color get red50 => Color(0XFFFCEFEF);
  Color get red600 => Color(0XFFE42F2F);

  // Teal
  Color get teal100 => Color(0XFFADDDCB);
  Color get teal200 => Color(0XFF84CBB0);
  Color get teal300 => Color(0XFF5BBA96);
  Color get teal400 => Color(0XFF32A97C);
  Color get teal50 => Color(0XFFD6EEE5);
  Color get teal800 => Color(0XFF1E654A);
  Color get teal900 => Color(0XFF144432);

  // White
  Color get whiteA700 => Color(0XFFFFFFFF);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
