import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

class ContainerPlaceholder extends StatelessWidget {

  final double width;
  final double height;
  final int lines;

  const ContainerPlaceholder({Key key, this.width, this.height, this.lines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: PlaceholderLines(
        lineHeight: height,
        count: lines,
        color: Colors.grey[300],
      ),
    );
  }
}
