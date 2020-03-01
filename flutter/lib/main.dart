import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/i10n/localization_intl.dart';
import 'package:myapp/locals/ProjectLocalizationsDelegate.dart';
import 'package:myapp/routes/RouteConfig.dart';
import 'package:myapp/routes/StartAd.dart';

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
        home: DefaultTextStyle(
          style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 16),
          child: StartAd(),
        ));
  }
}
