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
    print('是否有生物信息:' + canCheckBiometrics.toString());
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
      return new CupertinoTabScaffold(
        tabBar: new CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                title: new Text("首页"), icon: new Icon(Icons.chat_bubble)),
            BottomNavigationBarItem(
                title: new Text("好友"), icon: new Icon(Icons.collections)),
            BottomNavigationBarItem(
                title: new Text("我的"), icon: new Icon(CupertinoIcons.person)),
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
      );
    }
  }
}
