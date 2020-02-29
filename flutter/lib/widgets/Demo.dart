import 'package:flutter/material.dart';
import 'package:myapp/widgets/NumberInput.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(title: new Text('组件示例')),
          body: Column(children: <Widget>[
            NumberInput(
              (value) {
                print('NumberInput:' + value.toString());
              },
              step: 0.5,
              maxValue: 10,
              minValue: -5,
            ),
          ])),
    );
  }
}
