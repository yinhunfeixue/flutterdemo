import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/widgets/AutoCoolButton.dart';
import 'package:myapp/widgets/Box.dart';
import 'package:myapp/widgets/CodeInput.dart';
import 'package:myapp/widgets/NumberInput.dart';
import 'package:myapp/widgets/NumberPad.dart';

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
            RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    child: Box(
                      child: CodeInput((List<String> data) {
                        if (data[0] == '1') {
                          Fluttertoast.showToast(
                              msg: '输入完成: ' + data.toString());
                          Navigator.of(context).pop();
                        } else {
                          Fluttertoast.showToast(msg: '第一个数字为1才正确');
                        }
                      }),
                    ));
              },
              child: Text('验证码输入'),
            ),
            AutoCoolButton(
              () async {
                Fluttertoast.showToast(msg: '触发成功');
                return true;
              },
              text: '点击冷却',
              coolTime: 7000,
            )
          ])),
    );
  }
}
