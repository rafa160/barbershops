import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';

class HourComponent extends StatelessWidget {

  final HourModel hourModel;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const HourComponent({Key key, this.hourModel, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.11,
          child: Column(
            children: [
              Flexible(child: Divider()),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        hourModel.hour,
                        style: timeText,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      flex: 4,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.1,
                            color: hourModel.available == true ? Colors.teal.withOpacity(0.45) : Colors.red.withOpacity(0.5),
                          ),
                          hourModel.available == false ? Positioned(
                            bottom: 10,
                            right: 4,
                            child: FaIcon(
                              FontAwesomeIcons.lock,
                              size: 15,
                            ),
                          ) : Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Divider(
                  thickness: 5,
                  color: Colors.black,
                ),
              ),
            ],
          ),
      ),
    );
  }
}
