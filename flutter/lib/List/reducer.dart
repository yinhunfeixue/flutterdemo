import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/List/Item/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListState>>{
      ListAction.action: _onAction,
      ListAction.initList: _initList,
    },
  );
}

ListState _onAction(ListState state, Action action) {
  final ListState newState = state.clone();
  return newState;
}

ListState _initList(ListState state, Action action) {
  final ListState newState = state.clone();
  final List<ItemState> data = action.payload ?? <ItemState>[];
  newState.items = data;
  return newState;
}
