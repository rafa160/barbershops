import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/register_model.dart';

class NewCardClientInfo extends StatelessWidget {

  final RegisterModel register;

  const NewCardClientInfo({Key key, this.register}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, ct){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height* 0.1,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Container(
                      child: Text(register.hour, style:typeText,),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 8,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex:4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child:CircleAvatar(
                              backgroundColor: Colors.teal[200],
                              child:  FaIcon(
                                FontAwesomeIcons.userCircle,
                                size: 28,
                                color: Colors.white,
                              ),
                              radius: 20.0,
                            )
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 10,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  register.hour,
                                  style: typeText
                                ),
                                new Text(
                                  register.userModel.name,
                                  style: alertDialogTextTitle
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
