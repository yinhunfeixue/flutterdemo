import 'package:flutter/material.dart';

class WidgetCreater {
  static createButton(VoidCallback onPressed, String text) {
    return RaisedButton(onPressed: onPressed, child: Text(text));
  }
}
