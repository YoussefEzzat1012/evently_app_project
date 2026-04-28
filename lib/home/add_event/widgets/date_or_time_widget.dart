import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_styles.dart';

class DateOrTimeWidget extends StatelessWidget {
  final IconData icon;
  final String eventDateOrTime;
  final String chooseDateText;
  VoidCallback onChooseDateOrTime;

  DateOrTimeWidget({
    super.key,
    required this.icon,
    required this.eventDateOrTime,
    required this.onChooseDateOrTime,
    required this.chooseDateText,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).cardColor,),
        SizedBox(width: width * 0.04),
        Text(eventDateOrTime, style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(width: width * 0.02),
        Spacer(),
        TextButton(
          onPressed: onChooseDateOrTime,
          child: Text(
            chooseDateText,
            style: AppStyle.bold16Primary,
          ),
        ),
      ],
    );
  }
}
