import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/base_button.dart';

import 'progress_indicator.dart';

class CustomElevatedButton extends BaseButton {
  CustomElevatedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.processing = false,
    this.title = 'Loading...',
    this.textColor = Colors.white,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,

    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    double? height,
    double? width,
    required String text,
  }) : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );

  final BoxDecoration? decoration;
  final Color textColor;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final bool processing;
  final String title ;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => (processing)
      ? Container(
          height: this.height ?? 55.v,
          width: this.width ?? double.maxFinite,
          margin: margin,
          decoration: decoration,
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {},
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 15,
                      width: 15,
                      child: ProgressIndicators.circularProgressBar()),
                      const SizedBox(width: 13,),
                  Text(title, style: TextStyle(fontSize: 15, color: textColor),)
                ],
              ),
            ),
          ),
        )
      : Container(
          height: this.height ?? 55.v,
          width: this.width ?? double.maxFinite,
          margin: margin,
          decoration: decoration,
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: isDisabled ?? false ? null : onPressed ?? () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leftIcon ?? const SizedBox.shrink(),
                Text(
                  text,
                  style:
                      TextStyle(fontSize: 17, color:  textColor),
                ),
                rightIcon ?? const SizedBox.shrink(),
              ],
            ),
          ),
        );
}
