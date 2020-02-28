import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/models/ChatItemData.dart';
import 'package:myapp/widgets/Box.dart';

class ChatList extends StatefulWidget {
  @override
  ChatListState createState() => new ChatListState();
}

class ChatListState extends State<ChatList> {
  List<ChatItemData> userList = <ChatItemData>[];

  ChatListState() {
    this.userList = this.requestChatList();
  }

  requestChatList() {
    List<ChatItemData> result = <ChatItemData>[];
    for (int i = 0; i < 100; i++) {
      String message = "新的消息";
      if (i % 4 == 0) {
        message = '很长的消息';
      }
      result.add(
          new ChatItemData(i.toString(), "昵称" + i.toString(), "", message));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final height = 50.0;
    final gap = 10.0;
    return new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
          middle: new Text('微信'),
          trailing: new Icon(CupertinoIcons.add),
        ),
        child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    print('tap2');
                    Navigator.pushNamed(context, 'chatDetail',
                        arguments: this.userList[index]);
                  },
                  child: new Row(
                    children: <Widget>[
                      new Box(
                          margin: gap,
                          borderRadius: 10,
                          borderRadiusTopLeft: 20,
                          border:
                              new BorderSide(color: Colors.black12, width: 2),
                          backgroundColor: Colors.green,
                          child: new Icon(Icons.person, size: height)),
                      new Box(
                        flex: 1,
                        height: height,
                        borderBottom: new BorderSide(color: Colors.black26),
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Text(
                                this.userList[index].name,
                                style: TextStyle(fontSize: 16),
                              ),
                              new Text(
                                this.userList[index].message,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black54),
                              ),
                            ]),
                      ),
                    ],
                  ));
            },
            itemCount: this.userList.length));
  }
}
