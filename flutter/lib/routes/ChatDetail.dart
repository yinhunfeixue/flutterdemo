import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/ChatItemData.dart';
import 'package:myapp/models/ChatMessage.dart';
import 'package:myapp/widgets/Box.dart';

class ChatDetail extends StatefulWidget {
  @override
  ChatDetailState createState() {
    return new ChatDetailState();
  }
}

class ChatDetailState extends State<ChatDetail> {
  List<ChatMessage> messageList = <ChatMessage>[];
  ChatDetailState() {
    this._requestData();
  }

  @override
  Widget build(BuildContext context) {
    ChatItemData args = ModalRoute.of(context).settings.arguments;
    String title = args.name;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CupertinoNavigationBar(middle: new Text('$title')),
      body: new Column(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: ListView.builder(
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final message = messageList[index];
                    bool isRight = index % 3 == 0;
                    return new Box(
                        margin: 10,
                        child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection:
                                isRight ? TextDirection.rtl : TextDirection.ltr,
                            children: <Widget>[
                              new Box(
                                  border: new BorderSide(color: Colors.black26),
                                  padding: 10,
                                  marginRight: isRight ? null : 5,
                                  marginLeft: isRight ? 5 : null,
                                  backgroundColor:
                                      isRight ? Colors.green : null,
                                  child: new Icon(
                                    Icons.person,
                                    color: isRight ? Colors.white : null,
                                  )),
                              new CustomPaint(
                                  painter: new MyPainter(isRight: isRight),
                                  child: new Box(
                                      padding: 10,
                                      paddingLeft: isRight ? null : 20,
                                      paddingRight: isRight ? 20 : null,
                                      maxWidth: 300,
                                      child: new Text(
                                        message.message,
                                        style: TextStyle(color: Colors.black),
                                      )))
                            ]));
                  }),
            ),
          ),
          new Container(
              child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new TextField(
                  decoration: InputDecoration(
                      hintText: "请输入消息",
                      border: new UnderlineInputBorder(
                          borderSide:
                              new BorderSide(color: Colors.grey, width: 3)),
                      focusedBorder: new UnderlineInputBorder(
                          borderSide:
                              new BorderSide(color: Colors.red, width: 3)),
                      prefixIcon: Icon(Icons.message)),
                ),
              ),
              new RaisedButton(onPressed: () {}, child: Text('发送'))
            ],
          ))
        ],
      ),

      // new TextField(
      //         decoration: InputDecoration(
      //             hintText: "请输入消息",
      //             border: new UnderlineInputBorder(
      //                 borderSide: new BorderSide(color: Colors.grey, width: 3)),
      //             focusedBorder: new UnderlineInputBorder(
      //                 borderSide: new BorderSide(color: Colors.red, width: 3)),
      //             prefixIcon: Icon(Icons.message)),
      //       ),
      //  new Box(
      //     backgroundColor: Colors.black26,
      //     child: ListView.builder(
      //         itemCount: messageList.length,
      //         itemBuilder: (context, index) {
      //           final message = messageList[index];
      //           bool isRight = index % 3 == 0;
      //           return new Box(
      //               margin: 10,
      //               child: new Row(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   textDirection:
      //                       isRight ? TextDirection.rtl : TextDirection.ltr,
      //                   children: <Widget>[
      //                     new Box(
      //                         border: new BorderSide(color: Colors.black26),
      //                         padding: 10,
      //                         marginRight: isRight ? null : 5,
      //                         marginLeft: isRight ? 5 : null,
      //                         backgroundColor: isRight ? Colors.green : null,
      //                         child: new Icon(
      //                           Icons.person,
      //                           color: isRight ? Colors.white : null,
      //                         )),
      //                     new CustomPaint(
      //                         painter: new MyPainter(isRight: isRight),
      //                         child: new Box(
      //                             padding: 10,
      //                             paddingLeft: isRight ? null : 20,
      //                             paddingRight: isRight ? 20 : null,
      //                             maxWidth: 300,
      //                             child: new Text(
      //                               message.message,
      //                               style: TextStyle(color: Colors.black),
      //                             )))
      //                   ]));
      //         }))
    );
  }

  _requestData() {
    for (int i = 0; i < 20; i++) {
      final String msg = i % 3 == 0
          ? '短消息'
          : '长消息sfasdfas asdf *^(&9杨二营村 塔顶术有专攻厅gsa茜村 塔顶术有专攻厅gsa茜村 塔顶术有专攻厅gsa茜村 塔顶术有专攻厅gsa茜李春城要大概都是林原惠厅；一栢； ';
      ChatMessage item =
          new ChatMessage(i.toString(), 'from$i', 'to$i', msg, null);
      messageList.add(item);
    }
  }
}

class MyPainter extends CustomPainter {
  bool isRight = false;

  MyPainter({this.isRight});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;
    paint.color = isRight ? Colors.green : Colors.white;

    final double arrowWidth = 6;
    final double arrowHeight = 8;
    final double radius = 10;
    final double top = 0;
    final double arrowTop = 15;
    final double bottom = size.height;
    final double arrowBottom = arrowTop + arrowHeight;
    final double arrowCenter = (arrowTop + arrowBottom) / 2;

    double left = arrowWidth;
    double right = size.width;

    double arrowLeft = 0;
    double arrowRight = arrowWidth;

    if (isRight == true) {
      left = 0;
      right = size.width - arrowWidth;
      arrowLeft = size.width - arrowWidth;
      arrowRight = size.width;
    }

    Path path = new Path();
    // 画箭头的上线
    if (isRight == true) {
      path.moveTo(arrowRight, arrowCenter);
      path.lineTo(arrowLeft, arrowTop);
      path.lineTo(arrowLeft, arrowBottom);
      path.lineTo(arrowRight, arrowCenter);
    } else {
      path.moveTo(arrowLeft, arrowCenter);
      path.lineTo(arrowRight, arrowTop);
      path.lineTo(arrowRight, arrowBottom);
      path.lineTo(arrowLeft, arrowCenter);
    }
    path.addRRect(
        RRect.fromLTRBR(left, top, right, bottom, Radius.circular(radius)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
