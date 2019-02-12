import 'package:demo_flutter_inventory_app/src/model/item.dart';
import 'package:flutter/material.dart';

class ItemDetailForm extends StatefulWidget {
  @override
  _ItemDetailFormState createState() => _ItemDetailFormState();
}

class _ItemDetailFormState extends State<ItemDetailForm> {
  final _item = Item();

  var _qty = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Price'),
          ),

          //FIXME It's error when enable this view.
          //_quantityView(),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Supplier Name', hintText: 'Candy Supplier GmbH'),
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Supplier E-mail Address',
                hintText: 'supplier@gmail.com'),
          ),

          _selectImageButton()
        ],
      ),
    );
  }

  Widget _selectImageButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text('Image'),
        ),
        RaisedButton(onPressed: () {}, child: Text('SELECT IMAGE'),)
      ]
    );
  }

  Widget _quantityView() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RaisedButton(onPressed: () {}, child: Text('-')),
        TextFormField(
          decoration: InputDecoration(labelText: 'Quantity'),
        ),
        RaisedButton(onPressed: () {}, child: Text('+'))
      ]
    );
  }
}
