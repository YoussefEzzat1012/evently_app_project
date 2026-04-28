import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class EventTabItem extends StatelessWidget {
  final String eventName;
  final bool isSelected;
  final Color bgSelectedColor;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final Color borderColor;

  EventTabItem({
    super.key,
    required this.eventName,
    required this.isSelected,
    required this.bgSelectedColor,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.06,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.01,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(37),
        color: isSelected ? bgSelectedColor : AppColors.transparentColor,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        eventName,
        style: isSelected ? selectedTextStyle : unSelectedTextStyle,
      ),
    );
  }
}
