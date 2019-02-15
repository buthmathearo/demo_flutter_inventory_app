import 'package:demo_flutter_inventory_app/src/model/item.dart';
import 'package:demo_flutter_inventory_app/src/ui/view/quantity_selector.dart';
import 'package:flutter/material.dart';

class ItemDetailForm extends StatefulWidget {
  
  ItemDetailForm({Key key}) : super(key: key);
  
  @override
  ItemDetailFormState createState() => ItemDetailFormState();
}

class ItemDetailFormState extends State<ItemDetailForm> {
  // These keys needed to access data inside theirs corresponding widgets.
  // Before, I have used Callback to solve this.
  final _formViewKey = GlobalKey<FormState>();
  final _quantityViewKey = GlobalKey<QuantitySelectorState>();

  // TextField's controller
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _supplierNameController = TextEditingController();
  final _supplierPhoneController = TextEditingController();
  final _supplierEmailController = TextEditingController();

  final _item = Item();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formViewKey,
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: _buildForm(context),
      ),
    );
  }

  List<Widget> _buildForm(BuildContext context) {

    // TODO Add validation to all fields.
    final viewProductName = TextFormField(
      controller: _productNameController,
      decoration: InputDecoration(
          labelText: 'Product Name', border: UnderlineInputBorder()),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please fill it.';
        }
      },
    );

    final viewPrice = TextFormField(
      controller: _priceController,
      decoration: InputDecoration(labelText: 'Price'),
    );

    final viewSupplierName = TextFormField(
      controller: _supplierNameController,
      decoration: InputDecoration(
          labelText: 'Supplier Name', hintText: 'Candy Supplier GmbH'),
    );

    final viewSupplierPhone = TextFormField(
      controller: _supplierPhoneController,
      decoration: InputDecoration(
          labelText: 'Supplier Phone', hintText: 'e.g. +49 000-000-000'),
    );


    final viewSupplierEmail = TextFormField(
      controller: _supplierEmailController,
      decoration: InputDecoration(
          labelText: 'Supplier E-mail Address', hintText: 'supplier@gmail.com'),
    );

    final viewQuantity = QuantitySelector(key: _quantityViewKey);

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

  Item getItemIfValidated() {
    if (_formViewKey.currentState.validate()) {
      _item.productName = _productNameController.text;
      _item.price = _priceController.text;
      _item.quantity = _quantityViewKey.currentState.text;
      _item.supplierName = _supplierNameController.text;
      _item.supplierPhone = _supplierPhoneController.text;
      _item.supplierEmail = _supplierEmailController.text;
      // TODO Set imageUrl here.

      return _item;
    }
    return null;
  }

  // Check if user has input some data into the form.
  bool isEditing() {
    return _productNameController.text.isNotEmpty
        || _priceController.text.isNotEmpty
        || _quantityViewKey.currentState.text.isNotEmpty
        || _supplierNameController.text.isNotEmpty
        || _supplierPhoneController.text.isNotEmpty
        || _supplierEmailController.text.isNotEmpty;
  }

}
