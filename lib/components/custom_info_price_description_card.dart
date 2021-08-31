
import 'package:flutter/material.dart';


class CustomPriceDescriptionCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CustomPriceDescriptionCard({this.onTap, this.child, this.color, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      onLongPress: onLongPress,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.deepOrange, width: 2)),
          child:  Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Center(
                child: child
            ),
          ),
        ),
      ),
    );
  }
}
