import 'package:fish_redux/fish_redux.dart';

enum ListAction { action }

class ListActionCreator {
  static Action onAction() {
    return const Action(ListAction.action);
  }
}
