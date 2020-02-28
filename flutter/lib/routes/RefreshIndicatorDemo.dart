import 'package:flutter/material.dart';
import 'package:myapp/widgets/RefreshList.dart';

class RefreshIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RefreshIndicatorDemoState();
  }
}

class RefreshIndicatorDemoState extends State<RefreshIndicatorDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text('刷新列表')),
      body: new RefreshList(_request, _itemBuild),
    );
  }

  Future<ListResponse> _request(int page) async {
    List<String> result = [];
    /// 模拟网络请求
    int len = page > 1 ? 3 : 20;
    await Future.delayed(Duration(seconds: 1), () {
      for (int i = 0; i < len; i++) {
        result.add('第$page页的第$i项');
      }
    });
    // 模拟网络请求end
    return ListResponse(result, 54);
  }

  Widget _itemBuild(Object data, int index) {
    return new ListTile(
      title: new Text(data),
    );
  }
}
