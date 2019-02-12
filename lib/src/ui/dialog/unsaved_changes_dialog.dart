import 'package:flutter/material.dart';

void showUnsavedChangesDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text(
              'There are unsaved changes in the product information. Do you want to continue?'),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('KEEP EDITING')),
            FlatButton(
                onPressed: () {
                  // Dismiss dialog, and back to default route
                  // which is home screen.
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text('DISCARD'))
          ],
        );
      });
}
