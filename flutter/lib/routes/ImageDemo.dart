import 'package:flutter/material.dart';
import 'package:myapp/widgets/Box.dart';

class ImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: new Text('图片示例')),
        body: Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  new Text('原始图片'),
                  Box(
                    child: Image.asset('assets/pen.png'),
                  ),
                  new Text('指定尺寸圆形'),
                  Box(
                    borderRadius: double.maxFinite,
                    border: new BorderSide(color: Colors.red, width: 10),
                    child: new Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/pen.png',
                      ),
                    ),
                    width: 100,
                    height: 100,
                  ),
                  new Text('仅指定宽度椭圆'),
                  Box(
                    borderRadius: double.maxFinite,
                    border: new BorderSide(color: Colors.red, width: 5),
                    child: new Image(
                      image: AssetImage(
                        'assets/pen.png',
                      ),
                    ),
                    width: 300,
                  ),
                  new Text('指定尺寸圆角矩形'),
                  Box(
                    borderRadius: 10,
                    border: new BorderSide(color: Colors.green, width: 2),
                    child: new Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/pen.png',
                      ),
                    ),
                    width: 100,
                    height: 50,
                  ),
                  new Text('仅指定宽度的圆角矩形（无边框）'),
                  Box(
                    borderRadius: 10,
                    child: new Image(
                      image: AssetImage(
                        'assets/pen.png',
                      ),
                    ),
                    width: 100,
                  ),
                  new Text('仅指定高度的圆角矩形'),
                  Box(
                    borderRadius: 10,
                    border: new BorderSide(color: Colors.green, width: 2),
                    child: new Image(
                      image: AssetImage(
                        'assets/pen.png',
                      ),
                    ),
                    height: 100,
                  ),
                  new Text('固定尺寸，fit为fill'),
                  Box(
                    borderRadius: 10,
                    border: new BorderSide(color: Colors.green, width: 2),
                    child: new Image(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/pen.png',
                      ),
                    ),
                    width: 100,
                    height: 200,
                  ),
                  new Text('带padding'),
                  Box(
                    borderRadius: 10,
                    border: new BorderSide(color: Colors.green, width: 2),
                    padding: 10,
                    child: new Image(
                      image: AssetImage(
                        'assets/pen.png',
                      ),
                    ),
                    height: 100,
                  ),
                  new Text('带margin'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Box(
                        borderRadius: 10,
                        border: new BorderSide(color: Colors.green, width: 2),
                        child: new Image(
                          image: AssetImage(
                            'assets/pen.png',
                          ),
                        ),
                        height: 100,
                      ),
                      Box(
                        borderRadius: 10,
                        border: new BorderSide(color: Colors.green, width: 2),
                        margin: 10,
                        child: new Image(
                          image: AssetImage(
                            'assets/pen.png',
                          ),
                        ),
                        height: 100,
                      ),
                    ],
                  )
                ]))));
  }
}
