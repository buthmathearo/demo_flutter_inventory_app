import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({Key key, this.quantity = 0, this.padding = 16.0})
      : super(key: key);

  final double padding;
  final int quantity;

  @override
  QuantitySelectorState createState() {
    return new QuantitySelectorState();
  }
}

class QuantitySelectorState extends State<QuantitySelector> {
  Color _buttonColor;
  int _counter = 0;
  TextEditingController _textController = TextEditingController();

  // Getter.
  String get text => _textController.text;

  @override
  void initState() {
    super.initState();
    if (widget.quantity != 0) {
      _counter = widget.quantity;
      _textController.text = _counter.toString();
    }
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
      child: Text('ចំនួន'),
    );

    final minus = _smallButton(Icons.remove, () {
      if (_textController.text.isNotEmpty) {
        _counter = int.parse(_textController.text);
      }

      if (_counter > 0) {
        if (--_counter == 0) {
          _textController.text = '';
        } else {
          _textController.text = '$_counter';
        }
      }
    });

    final input = Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: SizedBox(
        width: 120.0,
        child: TextFormField(
          maxLines: 1,
          maxLength: 4,
          textAlign: TextAlign.center,
          decoration: InputDecoration(counterText: ''),
          controller: _textController,
          validator: (value) {
            if (value.isEmpty) {
              return 'បំពេញអោយបានត្រឹមត្រូវ';
            }
          },
        ),
      ),
    );

    final plus = _smallButton(Icons.add, () {
      if (_textController.text.isNotEmpty) {
        _counter = int.parse(_textController.text);
      }
      _textController.text = '${++_counter}';
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
