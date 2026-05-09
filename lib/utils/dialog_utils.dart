import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class DialogUtils {
  static void showDidalog({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.primaryColor),
            SizedBox(width: 10),
            Text(message, style: AppStyle.bold16Black),
          ],
        ),
      ),
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    Function? posAction,
    Function? negAction,
    required String title,
    String? posActionText,
    String? negActionText,
  }) {
    List<Widget>? actions = [];
    if (posActionText != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionText, style: AppStyle.bold16Primary),
        ),
      );
    }
    if (negActionText != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionText),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? "", style: AppStyle.bold16Black),
        actions: actions,
        content: Text(message, style: AppStyle.bold20Black),
      ),
    );
  }
}
