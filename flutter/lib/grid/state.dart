import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/models/GridModel.dart';

class GridState implements Cloneable<GridState> {
  List<GridModel> models;
  @override
  GridState clone() {
    return GridState()..models = models;
  }
}

GridState initState(Map<String, dynamic> args) {
  return GridState();
}
