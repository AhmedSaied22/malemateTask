import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/ui/app_colors.dart';

class CustomSnackBar {
  static SnackBar show({
    required BuildContext context,
    required String message,
    required SnackBarType snackBarType,
  }) {
    IconData iconData;
    Color bgColor;
    Color textColor = Colors.white;

    switch (snackBarType) {
      case SnackBarType.alert:
        iconData = Icons.info_outline;
        bgColor = AppColors.secondaryColor;
        break;
      case SnackBarType.done:
        iconData = Icons.check_circle_outline;
        bgColor = Colors.green;
        break;
      case SnackBarType.error:
        iconData = Icons.error_outline;
        bgColor = Colors.red;
        break;
    }

    return SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Icon(iconData, color: textColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(message, style: context.bodyLarge),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
    );
  }
}

enum SnackBarType {
  alert,
  done,
  error,
}
