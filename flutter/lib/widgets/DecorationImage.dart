import 'package:flutter/material.dart';
import 'package:myapp/widgets/Box.dart';

class DecorationImage extends Box {
  final ImageProvider image;
  final BoxFit boxFit;
  DecorationImage(this.image, this.boxFit);

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
