import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  Color themeColor;

  GlobalState clone() {
    return new GlobalState()..themeColor = themeColor;
  }
}
