import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(ListState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter adapter = viewService.buildAdapter(); //创建adapter

  return Scaffold(
      appBar: new AppBar(
        title: new Text('列表页'),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: adapter.itemBuilder, //把adapter配置到list
          itemCount: adapter.itemCount, //
        ),
      ));
}
