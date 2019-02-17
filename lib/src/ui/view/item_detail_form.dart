import 'dart:io';

import 'package:demo_flutter_inventory_app/src/model/item.dart';
import 'package:demo_flutter_inventory_app/src/ui/view/quantity_selector.dart';
import 'package:demo_flutter_inventory_app/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemDetailForm extends StatefulWidget {
  ItemDetailForm({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  ItemDetailFormState createState() => ItemDetailFormState();
}

class ItemDetailFormState extends State<ItemDetailForm> {
  // These keys needed to access data inside theirs corresponding widgets.
  // Before, I have used Callback to solve this.
  final _formViewKey = GlobalKey<FormState>();
  final _quantityViewKey = GlobalKey<QuantitySelectorState>();
  final _errorText =
      'បំពេញអោយបានត្រឹមត្រូវ'; //'Field needs to be input correctly.';

  // TextField's controller
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _supplierNameController = TextEditingController();
  final _supplierPhoneController = TextEditingController();
  final _supplierEmailController = TextEditingController();

  Item _item;

  bool _shouldEnable = true;

  bool _showImageErrorText = false;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
    if (_item == null) {
      _item = Item();
    } else {
      _shouldEnable = false;

      _productNameController.text = _item.productName;
      _priceController.text = _item.price.toString();
      _supplierNameController.text = _item.supplierName;
      _supplierPhoneController.text = _item.supplierPhone;
      _supplierEmailController.text = _item.supplierEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formViewKey,
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: _buildForm(),
      ),
    );
  }

  List<Widget> _buildForm() {
    final viewProductName = TextFormField(
      enabled: _shouldEnable,
      textCapitalization: TextCapitalization.words,
      controller: _productNameController,
      decoration: InputDecoration(
          labelText: 'ឈ្មោះទំនិញ', border: UnderlineInputBorder()),
      validator: (value) {
        if (value.isEmpty) {
          return _errorText;
        }
      },
    );

    final viewPrice = TextFormField(
      enabled: _shouldEnable,
      keyboardType: TextInputType.number,
      controller: _priceController,
      decoration: InputDecoration(labelText: 'តម្លៃ', prefixText: '\$ '),
      validator: (value) {
        if (value.isEmpty) {
          return _errorText;
        }
      },
    );

    final viewSupplierName = TextFormField(
      enabled: _shouldEnable,
      textCapitalization: TextCapitalization.words,
      controller: _supplierNameController,
      decoration: InputDecoration(labelText: 'អ្នកផ្គត់ផ្គង់'),
      validator: (value) {
        if (value.isEmpty) {
          return _errorText;
        }
      },
    );

    final viewSupplierPhone = TextFormField(
      enabled: _shouldEnable,
      keyboardType: TextInputType.phone,
      controller: _supplierPhoneController,
      decoration: InputDecoration(labelText: 'លេខទូរស័ព្ទអ្នកផ្គត់ផ្គង់'),
      validator: (value) {
        if (value.isEmpty) {
          return _errorText;
        }
      },
    );

    final viewSupplierEmail = TextFormField(
      enabled: _shouldEnable,
      keyboardType: TextInputType.emailAddress,
      controller: _supplierEmailController,
      decoration: InputDecoration(labelText: 'E-mail អ្នកផ្គត់ផ្គង់'),
      validator: (value) {
        if (value.isEmpty) {
          return _errorText;
        }
      },
    );

    final viewQuantity = QuantitySelector(
      key: _quantityViewKey,
      quantity: widget.item == null ? 0 : widget.item.quantity,
    );

    final viewImageSelector = _viewImageSelector();

    final viewImage = _imageView(_item.imagePath);

    return [
      viewProductName,
      viewPrice,
      viewQuantity,
      viewSupplierName,
      viewSupplierPhone,
      viewSupplierEmail,
      viewImageSelector,
      viewImage
    ];
  }

  Widget _imageView(String imagePath) {
    var image;
    if (imagePath == null) {
      image = Container();
    } else {
      image = isAsset(imagePath)
          ? Image.asset(imagePath)
          : Image.file(File(imagePath));
    }
    return Container(
      child: image,
    );
  }

  Widget _viewImageSelector() {
    // [AbsorbPointer] Disable/Enable its child by setting
    // absorbing: true/false.
    return AbsorbPointer(
      absorbing: !_shouldEnable,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text('រូបភាព ទំនិញ'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RaisedButton(
              onPressed: () async {
                final image =
                    await ImagePicker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _item.imagePath = image.path;
                  _showImageErrorText = false;
                });
              },
              child: Text('ជ្រើសរើស រូបភាព'),
            ),
            _imageErrorText()
          ],
        )
      ]),
    );
  }

  Widget _imageErrorText() {
    if (_showImageErrorText) {
      return Text(
        'សូមបញ្ចូលរូបភាពទំនិញ',
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Container();
    }
  }

  Item getItemIfValidated() {
    final allFieldsValidated = _formViewKey.currentState.validate();
    if (_hasItemImage() && allFieldsValidated) {
      _item.productName = _productNameController.text;
      _item.price = double.parse(_priceController.text);
      _item.quantity = int.parse(_quantityViewKey.currentState.text);
      _item.supplierName = _supplierNameController.text;
      _item.supplierPhone = _supplierPhoneController.text;
      _item.supplierEmail = _supplierEmailController.text;

      return _item;
    }
    return null;
  }

  bool _hasItemImage() {
    if (_item.imagePath == null) {
      setState(() {
        _showImageErrorText = true;
      });
      return false;
    } else {
      setState(() {
        _showImageErrorText = false;
      });
      return true;
    }
  }

  // Check if user has input some data into the form.
  bool isEditing() {
    // If [_shouldEnable] true, it's ADD NEW Detail Mode.
    // Else it's Editing Detail Mode.
    if (_shouldEnable) {
      return _productNameController.text.trim().isNotEmpty ||
          _priceController.text.trim().isNotEmpty ||
          _quantityViewKey.currentState.text.trim().isNotEmpty ||
          _supplierNameController.text.trim().isNotEmpty ||
          _supplierPhoneController.text.trim().isNotEmpty ||
          _supplierEmailController.text.trim().isNotEmpty;
    } else {
      return _quantityViewKey.currentState.text.trim() !=
          _item.quantity.toString();
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _supplierNameController.dispose();
    _supplierPhoneController.dispose();
    _supplierEmailController.dispose();
    super.dispose();
  }
}
