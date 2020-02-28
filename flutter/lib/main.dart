import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/List/page.dart';
import 'package:myapp/entrance/page.dart';
import 'package:myapp/grid/page.dart';
import 'package:myapp/i10n/localization_intl.dart';
import 'package:myapp/locals/ProjectLocalizationsDelegate.dart';
import 'package:myapp/routes/RouteConfig.dart';
import 'package:myapp/routes/StartAd.dart';
import 'package:myapp/widgets/Box.dart';
import 'package:myapp/widgets/HomePage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
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
        supportedLocales: [
          Locale('zh', 'CH'),
          Locale('en', 'US'),
        ],
        // home: HomePage());
        home: StartAd());
  }
}
