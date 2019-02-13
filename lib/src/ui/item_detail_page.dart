import 'package:demo_flutter_inventory_app/src/ui/dialog/unsaved_changes_dialog.dart';
import 'package:demo_flutter_inventory_app/src/ui/view/form_detail.dart';
import 'package:flutter/material.dart';

class ItemDetailPage extends StatefulWidget {
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  var _isEdited = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { // Handle when back pressed.
        if (_isEdited) {
          showUnsavedChangesDialog(context);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Item'),
          actions: [IconButton(icon: Icon(Icons.done), onPressed: () {})],
        ),
        body: SafeArea(child: ItemDetailForm()),
      ),
    );
  }
}
