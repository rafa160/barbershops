
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;

  const CustomButton({Key key, this.widget, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: Colors.orange,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
              onPressed: onPressed,
              child: widget
          ),
      ),
    );
  }
}