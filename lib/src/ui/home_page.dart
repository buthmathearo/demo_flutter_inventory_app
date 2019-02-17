import 'package:demo_flutter_inventory_app/src/model/item.dart';
import 'package:demo_flutter_inventory_app/src/ui/item_detail_page.dart';
import 'package:demo_flutter_inventory_app/src/ui/view/list_item.dart';
import 'package:demo_flutter_inventory_app/src/util/util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('គ្រប់គ្រងទំនិញ'),
        actions: [
          IconButton(
              icon: Icon(Icons.cloud_download),
              onPressed: () {
                setState(() {
                  _items.addAll(generateSampleListItems());
                });
              })
        ],
      ),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _body() {
    if (_items.isEmpty) {
      return _emptyItemView();
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListItem(_items[index], index, _onItemClick);
        },
        itemCount: _items.length,
      );
    }
  }

  void _onItemClick(Item item, int position) {
    _openDetailPage(item, position);
  }

  Widget _emptyItemView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(getAsset('ic_empty_white_box.png')),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
                'អ្នកមិនទាន់បានបញ្ចូលទំនិញនៅឡើយទេ'), //Start adding some items to your inventory
          )
        ],
      ),
    );
  }

  Widget _floatingActionButton() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            _openItemDetailPage();
          }),
    );
  }

  void _openItemDetailPage() async {
    final item =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemDetailPage();
    }));

    if (item != null) {
      setState(() {
        _items.add(item);
      });
    }
  }

  void _openDetailPage(Item item, int index) async {
    final object =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemDetailPage(item: item);
    }));

    if (object == null) return;

    if (object is Item) {
      setState(() {
        _items[index] = object;
      });
    } else if (object is ItemDetailTransaction) {
      if (object == ItemDetailTransaction.DELETE) {
        setState(() {
          _items.removeAt(index);
        });
      } else {
        setState(() {
          _items.clear();
        });
      }
    }
  }
}
