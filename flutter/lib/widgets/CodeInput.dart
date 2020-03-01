import 'package:flutter/material.dart';
import 'package:myapp/widgets/Box.dart';
import 'package:myapp/widgets/NumberPad.dart';

class CodeInput extends StatefulWidget {
  /// 验证码字符数量
  final double length;

  /// 输入完成的处理函数
  final void Function(List<String>) onSumbit;

  CodeInput(this.onSumbit, {this.length = 6});

  @override
  State<StatefulWidget> createState() {
    return new CodeInputState();
  }
}

class CodeInputState extends State<CodeInput> {
  List<String> valueList = [];
  @override
  Widget build(BuildContext context) {
    final maxLen = widget.length;
    List<Widget> textList = [];
    for (int i = 0; i < maxLen; i++) {
      textList.add(Box(
        width: 50,
        height: 50,
        border: BorderSide(color: Colors.grey),
        marginRight: i == maxLen ? 0 : 10,
        child: Center(
          child: new Text(
            i < valueList.length ? valueList[i] : '',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                decoration: TextDecoration.none),
          ),
        ),
      ));
    }
    return Box(
        backgroundColor: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
                top: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: textList,
                )),
            // NumberPad(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: NumberPad((key) {
                switch (key) {
                  case 'del':
                    if (valueList.length > 0) {
                      valueList.removeLast();
                    }
                    break;
                  case 'clear':
                    valueList.clear();
                    break;
                  default:
                    if (valueList.length < maxLen) {
                      valueList.add(key);
                      // 如果输入了最后一个，则提交
                      if (valueList.length >= maxLen) {
                        if (widget.onSumbit != null) {
                          widget.onSumbit(valueList);
                        }
                      }
                    }
                    break;
                }
                this.setState(() {});
              }),
            )
          ],
        ));
  }
}
