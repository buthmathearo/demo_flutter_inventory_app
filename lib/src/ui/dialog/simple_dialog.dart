import 'package:flutter/material.dart';

void showSimpleDialog(BuildContext context,
    {String title,
    String message,
    String positiveButtonLabel,
    String negativeButtonLabel,
    Function positiveClick,
    Function negativeClick,
    bool canDismiss = true}) {
  showDialog(
      context: context,
      barrierDismissible: canDismiss,
      builder: (context) {
        return AlertDialog(
          title: title == null ? null : Text(title),
          content: message == null ? null : Text(message),
          actions: [
            // Negative Button
            FlatButton(
              onPressed: () {
                negativeClick();
              },
              child: Text(negativeButtonLabel ?? 'ចាកចេញ'),
            ),

            // Positive Button
            FlatButton(
                onPressed: () {
                  positiveClick();
                },
                child: Text(positiveButtonLabel ?? 'យល់ព្រម')),
          ],
        );
      });
}
