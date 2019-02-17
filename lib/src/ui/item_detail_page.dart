import 'package:demo_flutter_inventory_app/src/model/item.dart';
import 'package:demo_flutter_inventory_app/src/ui/dialog/item_detail_dialog.dart';
import 'package:demo_flutter_inventory_app/src/ui/view/item_detail_form.dart';
import 'package:flutter/material.dart';

enum ItemDetailTransaction { DELETE, DELETE_ALL }

class ItemDetailPage extends StatefulWidget {
  ItemDetailPage({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final _detailFormKey = GlobalKey<ItemDetailFormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Handle when back pressed.
        if (_detailFormKey.currentState.isEditing()) {
          showUnsavedChangesDialog(context);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: _title(),
          actions: _menu(),
        ),
        body: SafeArea(
            child: ItemDetailForm(
          key: _detailFormKey,
          item: widget.item,
        )),
      ),
    );
  }

  Widget _title() {
    return Text(widget.item == null ? 'បញ្ចូលទំនិញថ្មី' : 'កែប្រែទំនិញ');
  }

  List<Widget> _menu() {
    final List<Widget> menus = [
      IconButton(
          icon: Icon(Icons.done),
          onPressed: () {
            _onDonePressed(context);
          })
    ];

    if (widget.item != null) {
      final overflowMenu = PopupMenuButton(
        itemBuilder: (context) {
          final menuDeleteItem = PopupMenuItem(
            child: Text('លុបទំនិញនេះ'),
            value: 0,
          );
          final menuDeleteAllDate = PopupMenuItem(
            child: Text('លុបទំនិញទាំងអស់ចោល'),
            value: 1,
          );

          return [menuDeleteItem, menuDeleteAllDate];
        },
        onSelected: (int value) {
          switch (value) {
            case 0:
              _onMenuDeleteItemClick();
              break;
            case 1:
              _onMenuDeleteAllDateClick();
              break;
          }
        },
      );
      menus.add(overflowMenu);
    }
    return menus;
  }

  void _onMenuDeleteItemClick() {
    showConfirmDeleteDialog(context, () {
      _backToHomePage(context, ItemDetailTransaction.DELETE);
    });
  }

  void _onMenuDeleteAllDateClick() {
    showConfirmDeleteDialog(context, () {
      _backToHomePage(context, ItemDetailTransaction.DELETE_ALL);
    });
  }

  void _onDonePressed(BuildContext context) {
    // Do validation in the form, and return [Item] if
    // everything is validated.
    final item = _detailFormKey.currentState.getItemIfValidated();
    if (item != null) {
      _backToHomePage(context, item);
    }
  }

  void _backToHomePage(BuildContext context, dynamic object) {
    Navigator.pop(context, object);
  }
}
