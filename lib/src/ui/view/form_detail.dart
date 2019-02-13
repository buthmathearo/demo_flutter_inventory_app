import 'package:demo_flutter_inventory_app/src/ui/view/quantity_selector.dart';
import 'package:flutter/material.dart';

class ItemDetailForm extends StatefulWidget {
  @override
  _ItemDetailFormState createState() => _ItemDetailFormState();
}

class _ItemDetailFormState extends State<ItemDetailForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: _buildForm(context),
      ),
    );
  }

  List<Widget> _buildForm(BuildContext context) {
    final viewProductName = TextFormField(
      decoration: InputDecoration(
          labelText: 'Product Name', border: UnderlineInputBorder()),
    );

    final viewPrice = TextFormField(
      decoration: InputDecoration(labelText: 'Price'),
    );

    final viewSupplierName = TextFormField(
      decoration: InputDecoration(
          labelText: 'Supplier Name', hintText: 'Candy Supplier GmbH'),
    );

    final viewSupplierPhone = TextFormField(
      decoration: InputDecoration(
          labelText: 'Supplier Phone', hintText: 'e.g. +49 000-000-000'),
    );


    final viewSupplierEmail = TextFormField(
      decoration: InputDecoration(
          labelText: 'Supplier E-mail Address', hintText: 'supplier@gmail.com'),
    );

    final viewQuantity = QuantitySelector();

    final viewImageSelector = _viewImageSelector();

    return [
      viewProductName,
      viewPrice,
      viewQuantity,
      viewSupplierName,
      viewSupplierPhone,
      viewSupplierEmail,
      viewImageSelector
    ];
  }

  Widget _viewImageSelector() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text('Image'),
      ),
      RaisedButton(
        onPressed: () {},
        child: Text('SELECT IMAGE'),
      )
    ]);
  }
}
