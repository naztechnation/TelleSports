import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tellesports/core/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.textStyle,
    this.obscureText = false,

    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    
    this.maxLines,
    this.maxLength = 200,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
    this.inputFormatters,
      this.onChanged,
      this.onTap = null,

  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  

  final TextEditingController? controller;

  final ValueChanged<String>? onChanged;

    final GestureTapCallback? onTap;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final int? maxLength;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;
  final bool readOnly;

  final FormFieldValidator<String>? validator;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400),
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          decoration: decoration,
          validator: validator,
          inputFormatters: inputFormatters,
            onChanged: onChanged,
            focusNode: focusNode,
          onTap: onTap,
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16, fontWeight: FontWeight.w300),
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        
        counter: SizedBox.shrink(),
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 14.v,
            ),
        fillColor: fillColor,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: appTheme.blueGray100,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: appTheme.blueGray100,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: appTheme.blueGray100,
                width: 1,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: appTheme.red600,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: appTheme.red600,
            width: 1,
          ),
        ),
        errorStyle: TextStyle(
          color: appTheme.red600,
          fontSize: 14.fSize,
        ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillBlueGray => OutlineInputBorder(
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get outlineBlueGrayTL17 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(17.h),
        borderSide: BorderSide(
          color: appTheme.blueGray100,
          width: 1,
        ),
      );
  static OutlineInputBorder get outlineBlack => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide: BorderSide.none,
      );
}
