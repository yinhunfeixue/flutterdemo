import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:myapp/paint/OvalBorder.dart';

/// ### 一个容器盒子，包含以下设置的组件
/// 如果有多个方向的值，例如padding。一般可统一设置，也可以单独设置每个方向的外边距。例如padding:10,  paddingLeft:20
/// + 外边距--margin
/// + 内边距--padding
/// + 边框--border
/// + 圆角--borderRadius，设置圆角后，会裁切内部元素
/// + 纯色背景-backgroundColor
/// + 画笔背景--background
/// + 图片背景--backgroundImage
/// + flex
/// + width
/// + height
/// + maxWidth
/// + maxHeight
/// + minWidth
/// + minHeight
///
/// ### 注意事项
/// + 因为flutter的限制，当4个边框设置不同的值时，**不能**设置borderRadius相关的属性
class Box extends StatelessWidget {
  final Widget child;

  /// flex值，父元素是row, columns,flex时有效
  final int flex;

  /// 宽度
  final double width;
  final double height;

  final double maxWidth;
  final double maxHeight;
  final double minWidth;
  final double minHeight;

  final double margin;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;

  /// 内边距，对应Container组件
  final double padding;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;

  /// 边框，对应DecoratedBox
  final BorderSide border;
  final BorderSide borderLeft;
  final BorderSide borderRight;
  final BorderSide borderTop;
  final BorderSide borderBottom;

  /// 圆角
  final double borderRadius;
  final double borderRadiusTopLeft;
  final double borderRadiusTopRight;
  final double borderRadiusBottomLeft;
  final double borderRadiusBottomRight;

  /// 背景色
  final Color backgroundColor;
  final Gradient background;
  final DecorationImage backgroundImage;

  Box(
      {this.child,

      ///
      this.width,
      this.height,
      this.maxWidth,
      this.maxHeight,
      this.minWidth,
      this.minHeight,

      ///
      this.margin,
      this.marginLeft,
      this.marginRight,
      this.marginTop,
      this.marginBottom,

      ///
      this.padding,
      this.paddingLeft,
      this.paddingRight,
      this.paddingTop,
      this.paddingBottom,

      ///
      this.border,
      this.borderLeft,
      this.borderRight,
      this.borderTop,
      this.borderBottom,

      ///
      this.borderRadius,
      this.borderRadiusTopLeft,
      this.borderRadiusTopRight,
      this.borderRadiusBottomLeft,
      this.borderRadiusBottomRight,

      ///
      this.flex,

      ///
      this.backgroundColor,
      this.backgroundImage,
      this.background});
  @override
  Widget build(BuildContext context) {
    Widget result = new Container(
        constraints: BoxConstraints(
            maxWidth: this.maxWidth ?? double.infinity,
            maxHeight: this.maxHeight ?? double.infinity,
            minWidth: minWidth ?? 0,
            minHeight: minHeight ?? 0),
        width: width,
        height: height,
        margin: this._getMarin(),
        decoration: this._getDecoration(),
        child: this._getContent());
    // 如果设置了flex，则用Expanded包裹
    if (this.flex == null) {
      return result;
    } else {
      return new Expanded(flex: this.flex, child: result);
    }
  }

  bool _isCircle() {
    return borderRadius == double.maxFinite;
  }

  Widget _getContent() {
    Widget content = this._getPadding() == null
        ? child
        : new Padding(padding: this._getPadding(), child: child);
    // 如果有圆角，需要加上clip
    if (borderRadius != null) {
      if (_isCircle()) {
        content = ClipOval(
          child: content,
        );
      } else {
        content = ClipRRect(
          borderRadius: _getClipRadius(),
          child: content,
        );
      }
    }
    return content;
  }

  Decoration _getDecoration() {
    if (_isCircle()) {
      return new ShapeDecoration(
          shape: OvalBorder(side: this._getBorder().left),
          color: this.backgroundColor,
          gradient: this.background,
          image: this.backgroundImage);
    } else {
      return new BoxDecoration(
          border: this._getBorder(),
          borderRadius: this._getBorderRadius(),
          color: this.backgroundColor,
          gradient: this.background,
          image: this.backgroundImage);
    }
  }

  Border _getBorder() {
    BorderSide left = this.borderLeft ?? this.border;
    BorderSide right = this.borderRight ?? this.border;
    BorderSide top = this.borderTop ?? this.border;
    BorderSide bottom = this.borderBottom ?? this.border;

    if (left == null && right == null && top == null && bottom == null) {
      return null;
    } else {
      return new Border(
          left: left ?? BorderSide.none,
          right: right ?? BorderSide.none,
          top: top ?? BorderSide.none,
          bottom: bottom ?? BorderSide.none);
    }
  }

  EdgeInsets _getMarin() {
    double left = this.marginLeft ?? this.margin;
    double right = this.marginRight ?? this.margin;
    double top = this.marginTop ?? this.margin;
    double bottom = this.marginBottom ?? this.margin;
    if (left == null && right == null && top == null && bottom == null) {
      return null;
    }
    return EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0);
  }

  EdgeInsets _getPadding() {
    double left = this.paddingLeft ?? this.padding;
    double right = this.paddingRight ?? this.padding;
    double top = this.paddingTop ?? this.padding;
    double bottom = this.paddingBottom ?? this.padding;
    if (left == null && right == null && top == null && bottom == null) {
      return null;
    }
    return EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0);
  }

  BorderRadius _getClipRadius() {
    BorderRadius borderRadius = _getBorderRadius();
    if (borderRadius == null) {
      return null;
    }
    Border border = _getBorder();
    if (border == null) {
      return borderRadius;
    }

    return BorderRadius.only(
      topLeft: Radius.elliptical(
          Math.max(0, borderRadius.topLeft.x - border.left.width),
          Math.max(0, borderRadius.topLeft.y - border.top.width)),
      topRight: Radius.elliptical(
          Math.max(0, borderRadius.topRight.x - border.right.width),
          Math.max(0, borderRadius.topRight.y - border.top.width)),
      bottomLeft: Radius.elliptical(
          Math.max(0, borderRadius.bottomLeft.x - border.left.width),
          Math.max(0, borderRadius.bottomLeft.y - border.bottom.width)),
      bottomRight: Radius.elliptical(
          Math.max(0, borderRadius.bottomRight.x - border.right.width),
          Math.max(0, borderRadius.bottomRight.y - border.bottom.width)),
    );
  }

  BorderRadius _getBorderRadius() {
    double topLeft = this.borderRadiusTopLeft ?? this.borderRadius;
    double topRight = this.borderRadiusTopRight ?? this.borderRadius;
    double bottomLeft = this.borderRadiusBottomLeft ?? this.borderRadius;
    double bottomRight = this.borderRadiusBottomRight ?? this.borderRadius;
    if (topLeft == null &&
        topRight == null &&
        bottomLeft == null &&
        bottomRight == null) {
      return null;
    }

    return BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? 0),
        topRight: Radius.circular(topRight ?? 0),
        bottomLeft: Radius.circular(bottomLeft ?? 0),
        bottomRight: Radius.circular(bottomRight ?? 0));
  }
}

class OClipper extends CustomClipper<RRect> {
  final double borderWidth;
  OClipper(this.borderWidth);

  @override
  RRect getClip(Size size) {
    return RRect.fromLTRBXY(
        0, 0, size.width, size.height, size.width / 2, size.height / 2);
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) {
    return true;
  }
}

enum Direction { LEFT, RIGHT, TOP, BOTTOM }
