import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

class CustomContainerPlaceholder extends StatefulWidget {

  final double width;
  final double height;
  final int lines;

  const CustomContainerPlaceholder({
    Key key, this.width, this.height, this.lines
  }) : super(key: key);

  @override
  _AnimatedWrapperState createState() => _AnimatedWrapperState();
}

class _AnimatedWrapperState extends State<CustomContainerPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: PlaceholderLines(
        lineHeight: widget.height,
        count: widget.lines,
        // animate: _animated,
        color: Colors.grey[300],
      ),
    );
  }
}