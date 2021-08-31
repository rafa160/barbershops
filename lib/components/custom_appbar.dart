import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/helpers/style.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  CustomAppBar({Key key, this.title}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  final String title;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedContainer(
      milliseconds: 1000,
      horizontalOffset: 50,
      position: 1,
      widget: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFf45d27), Color(0xFFf5851f)]),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  width: 35,
                  height: 20,
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Flexible(
                flex: 9,
                child: Text(
                  widget.title,
                  style: appBarTitle,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}