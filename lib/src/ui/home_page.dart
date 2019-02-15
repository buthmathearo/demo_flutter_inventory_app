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
        title: Text('Inventory Manager'),
        actions: [
          IconButton(icon: Icon(Icons.cloud_download), onPressed: () {})
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_items.isEmpty) {
      return _emptyItemView();
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListItem(_items[index]);
        },
        itemCount: _items.length,
      );
    }
  }

  Widget _emptyItemView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(getAsset('empty_white_box.png')),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Start adding some items to your inventory'),
          )
        ],
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            _openDetailPage(context);
          }),
    );
  }

  void _openDetailPage(BuildContext context) {
    Navigator.push<Item>(context, MaterialPageRoute(builder: (context) {
      return ItemDetailPage();
    })).then((item) {
      // Must check null here, even though we don't pass [Item]
      // from [ItemDetailPage].
      if (item != null) {
        setState(() {
          _items.add(item);
        });
      }
    });
  }
}
