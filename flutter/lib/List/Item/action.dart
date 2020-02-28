import 'package:fish_redux/fish_redux.dart';

enum ItemAction { action }

class ItemActionCreator {
  static Action onAction() {
    return const Action(ItemAction.action);
  }
}
