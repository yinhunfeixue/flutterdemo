import 'package:fish_redux/fish_redux.dart';

enum GridAction { action, loadData, openList }

class GridActionCreator {
  static Action onAction() {
    return const Action(GridAction.action);
  }

  static Action onLoadData() {
    return Action(GridAction.loadData);
  }

  static Action onOpenList() {
    return Action(GridAction.openList);
  }
}
