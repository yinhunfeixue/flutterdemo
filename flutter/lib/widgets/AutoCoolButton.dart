import 'dart:async';

import 'package:flutter/material.dart';

class AutoCoolButton extends StatefulWidget {
  /// 非冷却状态时显示的文字
  final String text;

  /// 一次操作的冷却时间，单位：毫秒
  final int coolTime;

  /// 点击后的处理方法，如果返回Future<bool>，表示开始冷却。设置为Future<bool>的原因是为了支持异步响应（例如网络请求）
  final Future<bool> Function() onSubmit;
  AutoCoolButton(this.onSubmit, {this.coolTime = 5000, this.text = '发送'});

  @override
  State<StatefulWidget> createState() {
    return AutoCoolButtonState();
  }
}

class AutoCoolButtonState extends State<AutoCoolButton> {
  DateTime coolEndTime;
  @override
  Widget build(BuildContext context) {
    String text = widget.text;
    // 如果冷却中，显示倒计时
    if (_isCooling) {
      text = (remainMilliseconds / 1000).toStringAsFixed(0) + '秒';
    }
    return RaisedButton(
      onPressed: _isCooling
          ? null
          : () async {
              if (_isCooling) {
                return;
              }
              bool result = await widget.onSubmit();
              if (result) {
                //开始冷却
                coolEndTime =
                    DateTime.now().add(Duration(milliseconds: widget.coolTime));
                _startCool();
                this.setState(() {});
              }
            },
      child: Text(text),
    );
  }

  void _startCool() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isCooling) {
        timer.cancel();
      }
      this.setState(() {});
    });
  }

  bool get _isCooling {
    return coolEndTime != null &&
        DateTime.now().millisecondsSinceEpoch <
            coolEndTime.millisecondsSinceEpoch;
  }

  int get remainMilliseconds {
    if (coolEndTime == null) {
      return 0;
    }
    return coolEndTime.millisecondsSinceEpoch -
        DateTime.now().millisecondsSinceEpoch;
  }
}
