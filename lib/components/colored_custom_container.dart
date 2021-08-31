import 'package:flutter/material.dart';

class ColoredCustomContainer extends StatelessWidget {

   final Widget child;
   final double width;
   final double height;

  ColoredCustomContainer({this.child,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFf45d27), Color(0xFFf5851f)]),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120))),
      child: child,
    );
  }
}
