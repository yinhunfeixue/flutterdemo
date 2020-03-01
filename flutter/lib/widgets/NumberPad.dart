import 'package:flutter/material.dart';
import 'package:myapp/widgets/Box.dart';

class NumberPad extends StatelessWidget {
  final void Function(String) onChange;
  final Map<String, String> valueMap = {
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    'clear': '清空',
    '0': '0',
    'del': '删除',
  };
  NumberPad(this.onChange);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    double gap = 5;
    double itemWidth = (MediaQuery.of(context).size.width - gap * 2) / 3;
    for (var key in valueMap.keys) {
      String value = valueMap[key];
      bool isEmpty = value.isEmpty;
      widgetList.add(Box(
        padding: gap,
        width: itemWidth,
        height: 70,
        child: isEmpty
            ? Box(
                backgroundColor: Colors.white70,
              )
            : Box(
                borderRadius: 5,
                child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      if (!isEmpty) {
                        if (this.onChange != null) {
                          this.onChange(key);
                        }
                      }
                    },
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 20),
                    ))),
      ));
    }
    return Box(
        padding: gap,
        backgroundColor: Color.fromARGB(255, 220, 220, 220),
        child: Wrap(
          children: widgetList,
        ));
  }
}
