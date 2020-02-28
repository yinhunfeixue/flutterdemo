import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/List/Item/component.dart';
import 'package:myapp/List/Item/state.dart';
import 'package:myapp/List/state.dart';

class ListAdapter extends DynamicFlowAdapter<ListState> {
  ListAdapter()
      : super(
          pool: <String, Component<Object>>{
            "MyItem": ItemComponent(),
          },
          connector: _ListConnector(),
          // reducer: buildReducer(),
        );
}

class _ListConnector extends ConnOp<ListState, List<ItemBean>> {
  @override
  List<ItemBean> get(ListState state) {
    //判断ListState里面的items数据是否为空
    if (state.items?.isNotEmpty == true) {
      //若不为空，把item数据转化成ItemBean的列表
      return state.items
          .map<ItemBean>((ItemState data) => ItemBean('MyItem', data))
          .toList(growable: true);
    } else {
      //若为空，返回空列表
      return <ItemBean>[];
    }
  }

  @override
  void set(ListState state, List<ItemBean> items) {
    if (items?.isNotEmpty == true) {
      state.items = List<ItemState>.from(
          items.map<ItemState>((ItemBean bean) => bean.data).toList());
    }
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
