import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/ui/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  String? errorText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final int? maxLines;
  final bool obscureText;
  final bool showLabel;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool isValidator;
  final Color? fillColor;
  final Widget? icon;
  final TextStyle? labelStyle;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final double? borderRadius;
  final EdgeInsetsGeometry? prefixPadding;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  int? minLines;
  CustomTextField(
      {super.key,
      this.hintText,
      this.prefixIcon,
      this.initialValue,
      this.suffixIcon,
      this.controller,
      this.onTap,
      this.showLabel = false,
      this.obscureText = false,
      this.maxLines = 1,
      this.readOnly = false,
      this.errorText,
      this.prefixIconColor,
      this.onChanged,
      this.isValidator = false,
      this.focusNode,
      this.suffixIconColor,
      this.borderRadius,
      this.prefixPadding,
      this.keyboardType,
      this.inputFormatters,
      this.validator,
      this.minLines,
      this.labelStyle,
      this.onFieldSubmitted,
      this.hintStyle,
      this.fillColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: context.bodyLarge,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      onTap: onTap,
      minLines: minLines,
      focusNode: focusNode,
      initialValue: initialValue,
      readOnly: readOnly,
      controller: controller,
      maxLines: obscureText ? 1 : maxLines,
      validator: validator ??
          (value) {
            if (isValidator) {
              if (value == null || value.trim().isEmpty) {
                return "هذا الحقل مطلوب.";
              } else {
                return null;
              }
            }
            return null;
          },
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
        if (errorText != null) {
          errorText = null;
        }
      },
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      obscuringCharacter: "*",
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: InputDecoration(
        icon: icon,
        labelStyle: labelStyle,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
        errorText: errorText,
        labelText: showLabel && controller != null ? hintText : null,
        hintText: hintText,
        fillColor: fillColor ?? AppColors.scaffoldBackgroundColor,
        hintStyle: hintStyle ?? context.hintText,
        prefixIcon: prefixIcon,
        prefix: prefixIcon == null
            ? const SizedBox(
                width: 10,
              )
            : null,
        filled: true,
        prefixIconColor: prefixIconColor,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        //   borderSide: const BorderSide(color: Colors.transparent),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(borderRadius ?? 14.r),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        //   borderSide: const BorderSide(color: AppColors.primaryColor),
        // ),
      ),
    );
  }
}
