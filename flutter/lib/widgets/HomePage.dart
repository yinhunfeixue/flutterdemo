import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/i10n/localization_intl.dart';
import 'package:myapp/widgetCreate/WidgetCreater.dart';
import 'package:myapp/widgets/ChatList.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  bool islogin = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(fontSize: 14, color: Colors.black),
        child: this._buildHome(context));
  }

  void _showImageDemo() {
    Navigator.pushNamed(context, 'imageDemo');
  }

  void _auth() async {
    var localAuth = LocalAuthentication();
    // 是否有生物信息功能
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if (!canCheckBiometrics) {
      Fluttertoast.showToast(msg: '无生物功能');
      return;
    }
    try {
      const iosStrings = const IOSAuthMessages(
          cancelButton: '取消',
          goToSettingsButton: 'settings',
          goToSettingsDescription: 'Please set up your Touch ID.',
          lockOut: 'Please reenable your Touch ID');
      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Please authenticate to show account balance',
          iOSAuthStrings: iosStrings);

      if (didAuthenticate) {
        setState(() {
          islogin = true;
        });
      } else {
        Fluttertoast.showToast(msg: '验证失败');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Widget _buildHome(context) {
    if (!islogin) {
      return new Scaffold(
          appBar: AppBar(
            title: new Text('App'),
            actions: <Widget>[
              new PopupMenuButton<String>(
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  this._selectView(Icons.message, '跟随系统', 'A'),
                  this._selectView(Icons.group_add, '中文', 'B'),
                  this._selectView(Icons.cast_connected, '英文', 'C'),
                ],
                onSelected: (String action) {
                  // 点击选项的时候
                  switch (action) {
                    case 'A':
                      setState(() {
                      //  local = null;
                      });
                      break;
                    case 'B':
                      setState(() {
                    //    local = new Locale('zh', 'CH');
                      });
                      break;
                    case 'C':
                      setState(() {
                      });
                      break;
                  }
                },
              ),
            ],
          ),
          drawer: _buildDrawer(),
          body: new Column(children: <Widget>[
            new RaisedButton(
              onPressed: () {
                this._showImageDemo();
              },
              child: new Text('图片demo'),
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'customBack');
              },
              child: new Text('拦截返回'),
            ),
            new CupertinoButton(
                onPressed: () {
                  this._auth();
                },
                child: new Text(DemoLocalizations.of(context).validate)),
            WidgetCreater.createButton(() {
              Navigator.pushNamed(context, 'refreshIndicatorDemo');
            }, "下拉刷新"),
          ]));
    } else {
      return Scaffold(
          drawer: _buildDrawer(),
          body: new CupertinoTabScaffold(
            tabBar: new CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                    title: new Text("首页"), icon: new Icon(Icons.chat_bubble)),
                BottomNavigationBarItem(
                    title: new Text("好友"), icon: new Icon(Icons.collections)),
                BottomNavigationBarItem(
                    title: new Text("我的"),
                    icon: new Icon(CupertinoIcons.person)),
              ],
            ),
            tabBuilder: (context, index) {
              // 如果用CupertinoTabView包裹，路由push时底部导航不会隐藏
              // return new CupertinoTabView(builder: (context) {
              switch (index) {
                case 0:
                  return new ChatList();
                default:
                  return new Container(child: new Text(index.toString()));
              }
              // });
            },
          ));
    }
  }

  _buildDrawer() {
    return new Drawer(
      semanticLabel: 'aaa',
      child: Stack(children: <Widget>[
        ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3127382059,2444917392&fm=26&gp=0.jpg')),
              ),
              child: new Text('自定义页头'),
            ),
            UserAccountsDrawerHeader(
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  child: new Text('赵'),
                ),
                CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582906355661&di=1317b3627dbad6ea4c9e99a9d102e728&imgtype=0&src=http%3A%2F%2Fimg2.yiihuu.com%2Fupimg%2Fmanage%2F2015%2F09%2F15%2F14422855791647.jpg'))
              ],
              currentAccountPicture: CircleAvatar(
                //backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3127382059,2444917392&fm=26&gp=0.jpg'),
              ),
              accountEmail: new Text("***@gmail.com"),
              accountName: new Text("自带的帐号页头"),
            ),
            ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text('退出'),
              onTap: () {},
            ),
            ListTile(
              leading: new Icon(Icons.monetization_on),
              title: new Text('帐户'),
              onTap: () {},
            )
          ],
        ),
        Positioned(
            bottom: 10,
            left: 10,
            child: IconButton(onPressed: () {}, icon: new Icon(Icons.settings)))
      ]),
    );
  }

  _selectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(icon, color: Colors.blue),
            new Text(text),
          ],
        ));
  }
}
