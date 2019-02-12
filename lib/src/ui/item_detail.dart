import 'package:flutter/material.dart';

class ItemDetailPage extends StatefulWidget {
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
        actions: [IconButton(icon: Icon(Icons.done), onPressed: () {})],
      ),
    );
  }
}
