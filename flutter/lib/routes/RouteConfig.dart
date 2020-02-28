import 'package:flutter/material.dart';
import 'package:myapp/routes/ChatDetail.dart';
import 'package:myapp/routes/CustomBack.dart';
import 'package:myapp/routes/ImageDemo.dart';
import 'package:myapp/routes/RefreshIndicatorDemo.dart';

class RouteConfig {
  static Map<String, Widget Function(BuildContext)> createData() {
    return {
      'chatDetail': (context) => new ChatDetail(),
      'imageDemo': (context) => new ImageDemo(),
      'customBack': (context) => new CustomBack(),
      'refreshIndicatorDemo': (context) => new RefreshIndicatorDemo(),
    };
  }
}
