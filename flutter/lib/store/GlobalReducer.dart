import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:myapp/store/GlobalAction.dart';
import 'package:myapp/store/GlobalState.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onchangeThemeColor,
    },
  );
}

GlobalState _onchangeThemeColor(GlobalState state, Action action) {
  final Color color =
  state.themeColor == Colors.green ? Colors.blue : Colors.green;
  return state.clone()..themeColor = color;
}