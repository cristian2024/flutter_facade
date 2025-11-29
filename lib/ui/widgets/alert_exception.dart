import 'package:flutter/material.dart';
import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';

class AlertException extends StatelessWidget {
  const AlertException(this.exception, {super.key});

  final CustomException exception;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Icon(
            Icons.cancel_outlined,
            color: context.getThemeData().colorScheme.error.withAlpha(60),
            size: 64,
          ),
      
          Text(
            exception.message,
            textAlign: TextAlign.center,
            style: context.getTextTheme().bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  static showAlert(
    BuildContext context, {
    required CustomException exception,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: AlertException(exception),
        );
      },
    );
  }
}
