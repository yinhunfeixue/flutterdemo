import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final BorderSide defaultInputBorder = BorderSide(color: Colors.grey);
  final BorderSide defaultInputFocusBorder = BorderSide(color: Colors.blue);
  final BorderSide disableBorder = BorderSide(color: Colors.grey);
  final double step;
  final void Function(double) onChange;
  final double defaultValue;
  final double minValue;
  final double maxValue;

  final BorderSide inputBorder;
  final BorderSide inputFocusBorder;
  final double width;
  final double height;

  NumberInput(this.onChange,
      {this.step = 1,
      this.minValue = 0,
      this.maxValue = 100,
      this.defaultValue = 0,
      this.width,
      this.height,
      this.inputBorder,
      this.inputFocusBorder});

  @override
  State<StatefulWidget> createState() {
    return NumberInputState();
  }
}

class NumberInputState extends State<NumberInput> {
  double value;
  TextEditingController _textController = new TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    this._adjustValue();
    _focusNode.addListener(() {
      if (hasFocus == true && _focusNode.hasFocus == false) {
        this._setStrValue(this._textController.text);
      }
      hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  void didUpdateWidget(NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    this._adjustValue();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: widget.inputBorder ?? widget.defaultInputBorder);
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: widget.inputFocusBorder ?? widget.defaultInputFocusBorder);
    return Container(
        width: widget.width,
        height: widget.height ?? 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[0-9.-]'))
                ],
                onEditingComplete: () {
                  this._setStrValue(this._textController.text);
                },
                focusNode: _focusNode,
                controller: _textController,
                decoration: InputDecoration(
                  border: inputBorder,
                  focusedBorder: inputFocusBorder,
                  fillColor: Colors.red,
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
            RaisedButton(
              onPressed: () {
                _setValue(value - widget.step);
              },
              child: new Text('-'),
            ),
            RaisedButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                _setValue(value + widget.step);
              },
              child: new Text('+'),
            )
          ],
        ));
  }

  double _parseStringToValue(String str) {
    double result = double.tryParse(str);
    if (result == null) {
      RegExp reg = RegExp('^\-?[0-9]+\.?[0-9]*');
      RegExpMatch match = reg.firstMatch(str);
      if (match != null) {
        String effectValue = str.substring(match.start, match.end);
        result = double.tryParse(effectValue);
      }
    }

    if (result == null) {
      result = widget.defaultValue;
    }
    return result;
  }

  void _setStrValue(String str) {
    String str = _textController.text;
    double value = _parseStringToValue(str);
    _setValue(value);
  }

  void _setValue(double newValue) {
    double oldValue = this.value;
    this.value = newValue;
    this._adjustValue();
    if (this.value != oldValue) {
      if (widget.onChange != null) {
        widget.onChange(this.value);
      }
    }
  }

  void _adjustValue() {
    double v = this.value;
    if (v == null) {
      v = widget.defaultValue;
    }

    if (v < widget.minValue) {
      v = widget.minValue;
    } else if (v > widget.maxValue) {
      v = widget.maxValue;
    }

    if (this.value != v) {
      setState(() {
        value = v;
      });
    }
    this._adjustInputText();
  }

  void _adjustInputText() {
    String str = value.toString();
    // 如果不相等，则设置
    if (str != _textController.text) {
      TextSelection selection = _textController.selection;
      _textController.text = str;

      int startSelection = selection.start;
      if (startSelection > str.length) {
        startSelection = str.length;
      }

      _textController.selection =
          TextSelection.fromPosition(TextPosition(offset: startSelection));
    }
  }
}
