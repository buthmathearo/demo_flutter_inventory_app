import 'dart:io';

import 'package:demo_flutter_inventory_app/src/model/item.dart';
import 'package:demo_flutter_inventory_app/src/util/util.dart';
import 'package:flutter/material.dart';

typedef void OnItemClick(Item item, int position);

class ListItem extends StatelessWidget {
  const ListItem(this._item, this._position, this._onItemClick, {Key key})
      : super(key: key);

  final _titleTextStyle = const TextStyle(fontSize: 22.0);
  final _quantityTextStyle = const TextStyle(fontSize: 30.0);
  final _priceTextStyle = const TextStyle(fontSize: 16.0);

  final Item _item;
  final int _position;
  final OnItemClick _onItemClick;

  @override
  Widget build(BuildContext context) => _buildItem(context);

  Widget _buildItem(BuildContext context) {
    final image = _image(_item.imagePath);

    final title = Text(
      _item.productName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: _titleTextStyle,
    );

    final price = Text(
      '${_item.price}\$',
      style: _priceTextStyle,
    );

    final quantity = Text(
      '${_item.quantity}',
      style: _quantityTextStyle,
      textAlign: TextAlign.right,
    );

    return Card(
      child: InkWell(
        highlightColor: Colors.blueGrey,
        onTap: () => _onItemClick(_item, _position),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            image,
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    Row(children: [Expanded(child: quantity)]),
                    price
                  ]),
            )
          ]),
        ),
      ),
    );
  }

  Widget _image(String imagePath) {
    var image = isAsset(imagePath)
        ? Image.asset(imagePath)
        : Image.file(File(imagePath));

    return Container(
      padding: EdgeInsets.only(right: 8.0),
      height: 100.0,
      child: image,
    );
  }
}
