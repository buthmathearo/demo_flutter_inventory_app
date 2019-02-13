import 'package:demo_flutter_inventory_app/src/model/item.dart';
import 'package:demo_flutter_inventory_app/src/util/util.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Item _item;

  ListItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: _buildImage(_item.imageUrl),
        title: Text(_item.productName),
        subtitle: _buildSubtitleView(_item),
      )
    );
  }

  Widget _buildImage(String url) {
    if (url == null || url.isEmpty) {
      return Image.asset(getAsset('placeholder.png'));
    } else {
      return Image.asset(url);
    }
  }

  Widget _buildSubtitleView(Item item) {
    return Container();
  }
}
