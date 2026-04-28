import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final Color? backGroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool hasIcon;
  final Widget? childIconWidget;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor = AppColors.primaryColor,
    this.borderColor = AppColors.transparentColor,
    this.textStyle,
    this.hasIcon = false,
    this.childIconWidget
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor!, width: 2),
        ),
      ),
      onPressed: onPressed,
      child: hasIcon? childIconWidget:
      Text(text ?? "", style: textStyle ?? AppStyle.medium16White),
    );
  }
}
