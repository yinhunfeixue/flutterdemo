import 'package:flutter/material.dart';

class OvalBorder extends ShapeBorder {
  final BorderSide side;
  OvalBorder({this.side});
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path result = new Path();
    result.addOval(rect);
    return result;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    Path result = new Path();
    result.addOval(rect);
    return result;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    final sideWidth = side.width;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        canvas.drawOval(
            Rect.fromLTWH(rect.left + sideWidth / 2, rect.top + sideWidth / 2,
                rect.width - sideWidth, rect.height - sideWidth),
            side.toPaint());
    }
  }

  @override
  ShapeBorder scale(double t) => OvalBorder(side: side.scale(t));

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }
}
