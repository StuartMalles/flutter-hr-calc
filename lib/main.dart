import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _displayValue = '';
  double _leftvalue;
  double _rightvalue;
  String _operator = '';

  final String _enter = 'Enter';
  final String _clear = 'Clear';

  void setOperator(String operator) {
    _operator = operator;

    setState(() {});
  }

  void setValue(String value) {
    (_operator.isEmpty)
        ? _leftvalue = double.parse(value)
        : _rightvalue = double.parse(value);

    setState(() {
      _displayValue = value;
    });
  }

  void performAction(String action) {
    double newdisplayvalue;

    if (action == _clear) {
      newdisplayvalue = 0;
    } else {
      if (_operator == '+') {
        newdisplayvalue = (_leftvalue + _rightvalue);
      }
      if (_operator == '-') {
        newdisplayvalue = (_leftvalue - _rightvalue);
      }
      if (_operator == '*') {
        newdisplayvalue = (_leftvalue * _rightvalue);
      }
      if ((_operator == '/') && (_rightvalue != 0)) {
        newdisplayvalue = (_leftvalue / _rightvalue);
      }
    }

    _leftvalue = null;
    _rightvalue = null;

    setState(() {
      _operator = '';
      _displayValue = newdisplayvalue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                _displayValue,
                textAlign: TextAlign.end,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Keypad('1', setValue),
              Keypad('2', setValue),
              Keypad('3', setValue),
              Keypad('+', setOperator, _operator)
            ],
          ),
          Row(
            children: <Widget>[
              Keypad('5', setValue),
              Keypad('6', setValue),
              Keypad('7', setValue),
              Keypad('-', setOperator, _operator)
            ],
          ),
          Row(
            children: <Widget>[
              Keypad('8', setValue),
              Keypad('9', setValue),
              Keypad('0', setValue),
              Keypad('*', setOperator, _operator)
            ],
          ),
          Row(
            children: <Widget>[
              Keypad(_enter, performAction),
              Keypad('0', setValue),
              Keypad(_clear, performAction),
              Keypad('/', setOperator, _operator)
            ],
          ),
        ],
      ),
    );
  }
}

class Keypad extends StatelessWidget {
  final String value;
  final Function process;
  final String selectedOperator;

  Keypad(this.value, this.process, [this.selectedOperator]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: (value == selectedOperator)
            ? BoxDecoration(border: Border.all())
            : null,
        child: RaisedButton(
          onPressed: () => process(value),
          child: Text(value),
        ),
      ),
    );
  }
}
