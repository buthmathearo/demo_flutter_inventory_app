import 'package:demo_flutter_inventory_app/src/model/item.dart';
import 'package:demo_flutter_inventory_app/src/ui/dialog/unsaved_changes_dialog.dart';
import 'package:demo_flutter_inventory_app/src/ui/view/form_detail.dart';
import 'package:flutter/material.dart';

class ItemDetailPage extends StatefulWidget {
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final _detailFormKey = GlobalKey<ItemDetailFormState>();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () { // Handle when back pressed.
        if (_detailFormKey.currentState.isEditing()) {
          showUnsavedChangesDialog(context);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Item'),
          actions: [IconButton(icon: Icon(Icons.done), onPressed: () {
            _onDonePressed(context);
          })],
        ),
        body: SafeArea(child: ItemDetailForm(key: _detailFormKey,)),
      ),
    );
  }

  void _onDonePressed(BuildContext context) {
    // Do validation in the form, and return [Item] if
    // everything is validated.
    final item = _detailFormKey.currentState.getItemIfValidated();
    if (item != null) {
      _backToHomePage(context, item);
    }
  }

  void _backToHomePage(BuildContext context, Item item) {
    Navigator.pop(context, item);
  }
}
