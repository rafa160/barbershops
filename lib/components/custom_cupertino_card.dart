import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/register_model.dart';

class CustomCupertinoCard extends StatelessWidget {

  final RegisterModel registerModel;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CustomCupertinoCard({Key key, this.registerModel, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: CupertinoCard(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.14,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text('${registerModel.hour}h - ${registerModel.userModel.name} - ${registerModel.checkDate}', style: subtitleMonthPageStyle,)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 14,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Flexible(child: Text(registerModel.userModel.whatsApp, style: titleForms,))
                  ],
                ),
              ],
            ),
          ),
        ),
        elevation: 2.0,
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(0.0),
        radius: BorderRadius.all(
          new Radius.circular(40.0),
        ),
      ),
    );
  }
}
