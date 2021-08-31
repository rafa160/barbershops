import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/helpers/style.dart';

class CustomInfoPageCard extends StatelessWidget {

  final FaIcon icon;
  final String text;
  final VoidCallback onTap;
  final double width;

  const CustomInfoPageCard({Key key, this.icon, this.text, this.onTap, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: 120,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFf68f32), Color(0xFFf8a457)]),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)
                  )
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    SizedBox(
                      height: 5,
                    ),
                    Text(text,style: buttonColors,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
