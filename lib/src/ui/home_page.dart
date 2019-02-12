import 'package:demo_flutter_inventory_app/src/ui/item_detail_page.dart';
import 'package:demo_flutter_inventory_app/src/util/util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Manager'),
        actions: [
          IconButton(icon: Icon(Icons.cloud_download), onPressed: () {})
        ],
      ),
      body: _emptyItemView(),
      floatingActionButton: _floatingActionButton(context),
    );
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
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemDetailPage();
    }));
  }
}
