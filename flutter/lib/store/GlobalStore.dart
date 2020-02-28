import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/store/GlobalReducer.dart';
import 'package:myapp/store/GlobalState.dart';

class GlobalStore {
  static Store<GlobalState> _globalStore;

  static Store<GlobalState> get store =>
      _globalStore ??= createStore(GlobalState(), buildReducer());
}
