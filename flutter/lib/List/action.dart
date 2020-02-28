import 'package:fish_redux/fish_redux.dart';

import 'Item/state.dart';

enum ListAction { action, initList }

class ListActionCreator {
  static Action onAction() {
    return const Action(ListAction.action);
  }

   static Action onInitList(List<ItemState> items) {
    return  Action(ListAction.initList, payload: items);
  }
}
