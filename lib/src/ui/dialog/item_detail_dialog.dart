import 'package:demo_flutter_inventory_app/src/ui/dialog/simple_dialog.dart';
import 'package:flutter/material.dart';

void showUnsavedChangesDialog(BuildContext context) {
  // 'There are unsaved changes
  // in the product information. Do you want to continue?',
  showSimpleDialog(context,
      canDismiss: false,
      message:
          'អ្នកមិនទាន់បានរក្សាទុក​​​ពត៌មាន​​របស់​ទំនិញ​​នេះ​ទេ។ ​តើអ្នកចង់បន្តធ្វើ​​ទេ?',
      positiveButtonLabel: 'បន្តធ្វើ',
      positiveClick: () => _dismiss(context),
      negativeButtonLabel: 'មិនធ្វើទៀតទេ',
      negativeClick: () {
        // Dismiss dialog, and back to default route
        // which is home screen.
        Navigator.popUntil(context, ModalRoute.withName('/'));
      });
}

void showConfirmDeleteDialog(BuildContext context, Function confirmClick) {
  showSimpleDialog(context,
      message: 'ច្បាស់អត់ថាចង់លុបហ្នឹង?',
      positiveClick: () {
        _dismiss(context);
        confirmClick();
      },
      negativeClick: () => _dismiss(context));
}

void _dismiss(BuildContext context) => Navigator.pop(context);
