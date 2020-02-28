import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/List/Item/state.dart';
import 'action.dart';
import 'state.dart';

Effect<ListState> buildEffect() {
  return combineEffects(<Object, Effect<ListState>>{
    ListAction.action: _onAction,
    Lifecycle.initState:_initList,
  });
}

void _onAction(Action action, Context<ListState> ctx) {}

void _initList(Action action, Context<ListState> ctx) {
  List<ItemState> data = [
    ItemState(content: "aaa", title: "a", type: 0),
    ItemState(content: "bb", title: "b", type: 0),
    ItemState(content: "cc", title: "c", type: 0),
  ];

  ctx.dispatch(ListActionCreator.onInitList(data));
}
