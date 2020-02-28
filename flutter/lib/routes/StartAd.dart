import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/widgets/Box.dart';

class StartAd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new StartAdState();
  }
}

class StartAdState extends State<StartAd> {
  int remainIndex = 5;
  Timer timer;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.network(
              'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2914964477,1439608823&fm=26&gp=0.jpg',
              fit: BoxFit.cover,
            )),
        Positioned(
          bottom: 10,
          right: 10,
          child: Text(
            '$remainIndex秒（跳过）',
            style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        remainIndex = remainIndex - 1;
        if (remainIndex <= 0) {
          timer.cancel();
          Navigator.pushReplacementNamed(context, 'home');
        }
      });
    });
  }
}
