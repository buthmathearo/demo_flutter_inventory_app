import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final double padding;

  QuantitySelector({this.padding = 16.0});

  @override
  _QuantitySelectorState createState() {
    return new _QuantitySelectorState();
  }
}

class _QuantitySelectorState extends State<QuantitySelector> {
  Color _buttonColor;
  int _counter = 0;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get default button color.
    _buttonColor = Theme.of(context).buttonColor;

    final label = Padding(
      padding: EdgeInsets.only(top: widget.padding),
      child: Text('Quantity'),
    );

    final minus = _smallButton(Icons.remove, () {
      if (_counter > 0) {
        if (--_counter == 0) {
          _textController.text = '';
        } else {
          _textController.text = '$_counter';
        }
      }
    });

    final input = Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 120.0,
        child: TextFormField(
          maxLines: 1,
          maxLength: 4,
          controller: _textController,
        ),
      ),
    );

    final plus = _smallButton(Icons.add, () {
      _textController.text= '${++_counter}';
    });

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [minus, input, plus],
        )
      ],
    ));
  }

  ButtonTheme _smallButton(IconData icon, Function onPressed) {
    return ButtonTheme(
      minWidth: 0,
      buttonColor: _buttonColor,
      child: RaisedButton(
        padding: EdgeInsets.all(4),
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}
