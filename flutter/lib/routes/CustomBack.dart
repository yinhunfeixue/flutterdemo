import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomBack extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CustomBackState();
  }
}

class CustomBackState extends State<CustomBack> {
  int lastBackTime;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          print('onWillPop');
          int now = DateTime.now().millisecondsSinceEpoch;
          if (lastBackTime == null || now - lastBackTime > 2000) {
            lastBackTime = now;
            Fluttertoast.showToast(msg: '连续点击才返回');
            return false;
          }
          return true;
        },
        child: Scaffold(appBar: AppBar(title: new Text('点一次不返回'))));
  }
}
