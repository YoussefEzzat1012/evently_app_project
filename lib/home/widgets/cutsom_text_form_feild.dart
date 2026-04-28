import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
typedef OnValidator = String? Function(String?)?;
class CutsomTextFormFeild extends StatelessWidget {
    Color borderSideColor;
    String? hintText;
    TextStyle? hintStyle;
    String? labelText;
    TextStyle? labelStyle;
    Widget? prefixIcon;
    Widget? suffixIcon;
    OnValidator? validator;
    TextInputType? keyboardType;
    bool obSecureText;
    String? obscuringCharacter;
    TextEditingController controller;
    int? maxLines;
   CutsomTextFormFeild({super.key, this.borderSideColor = Colors.grey,
     this.hintStyle,
     this.hintText,
     this.labelStyle,
     this.labelText,
     this.prefixIcon,
     this.suffixIcon,
     this.validator,
     this.keyboardType = TextInputType.text,
     this.obSecureText = false,
     this.obscuringCharacter,
     required this.controller,
     this.maxLines = 1,
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obSecureText,
      obscuringCharacter: obscuringCharacter ?? ".",
      controller: controller,
      decoration: InputDecoration(
        border: builtOutlineInputBorder(borderSideColor: borderSideColor),
        focusedBorder: builtOutlineInputBorder(borderSideColor: borderSideColor),
        errorBorder: builtOutlineInputBorder(borderSideColor: AppColors.redColor),
        focusedErrorBorder: builtOutlineInputBorder(borderSideColor: AppColors.redColor),
        hintText: hintText ,
        hintStyle: hintStyle ?? AppStyle.medium16Grey,
        labelText: labelText ,
        labelStyle: labelStyle ?? AppStyle.medium16Grey,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

OutlineInputBorder builtOutlineInputBorder({required Color borderSideColor}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: borderSideColor,
        width: 1,
      )
  );
}
