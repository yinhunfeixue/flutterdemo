import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/List/page.dart';
import 'package:myapp/entrance/page.dart';
import 'package:myapp/grid/page.dart';
import 'package:myapp/i10n/localization_intl.dart';
import 'package:myapp/locals/ProjectLocalizationsDelegate.dart';
import 'package:myapp/routes/RouteConfig.dart';
import 'package:myapp/widgets/HomePage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'entrance_page': EntrancePage(), //在这里添加页面
      'grid_page': GridPage(), //添加这一行
      'list_page': ListPage(),
    },
  );

  Locale local;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          new ProjectLocalizationsDelegate(),
          new DemoLocalizationsDelegate(customLocal: local),
        ],
        routes: RouteConfig.createData(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute<Object>(builder: (BuildContext context) {
            return routes.buildPage(settings.name, settings.arguments);
          });
        },
        supportedLocales: [
          Locale('zh', 'CH'),
          Locale('en', 'US'),
        ],
        home: _buildHome());
  }

  _buildHome() {
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
                    local = null;
                  });
                  break;
                case 'B':
                  setState(() {
                    local = new Locale('zh', 'CH');
                  });
                  break;
                case 'C':
                  setState(() {
                    print('set c');
                    local = new Locale('en', 'US');
                  });
                  break;
              }
            },
          ),
        ],
      ),
      body: HomePage(),
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
