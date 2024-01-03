import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(
          key: key,
        );

  final double? height;

  final Style? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 56.v,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        mediaQueryData.size.width,
        height ?? 56.v,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgOutline_1:
        return Container(
          height: 32.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: appTheme.gray400,
                width: 1.h,
              ),
            ),
          ),
        );
      case Style.bgOutline_4:
        return Container(
          height: 93.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            border: Border(
              bottom: BorderSide(
                color: appTheme.gray400,
                width: 1.h,
              ),
            ),
          ),
        );
      case Style.bgOutline:
        return Container(
          height: 84.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            border: Border(
              bottom: BorderSide(
                color: appTheme.blueGray100,
                width: 1.h,
              ),
            ),
          ),
        );
      case Style.bgOutline_2:
        return Container(
          height: 32.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: appTheme.gray50001,
                width: 1.h,
              ),
            ),
          ),
        );
      case Style.bgOutline_3:
        return Container(
          height: 93.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: appTheme.gray400,
                width: 1.h,
              ),
            ),
          ),
        );
      case Style.bgFill:
        return Container(
          height: 86.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgOutline_1,
  bgOutline_4,
  bgOutline,
  bgOutline_2,
  bgOutline_3,
  bgFill,
}
