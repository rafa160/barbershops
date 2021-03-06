import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';

class CustomPngCard extends StatelessWidget {

  final String month;
  final VoidCallback onTap;

  const CustomPngCard({Key key,  this.month, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool checkMonth = getActualMonthColors(month);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 168,
        width: 150,
        child: Card(
          color: checkMonth == true ? Colors.white :  Color(0xFFCDCDCD),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: checkMonth == true ? [Color(0xff40dedf), Color(0xff0fb2ea)] : [Color(0xFFCDCDCD), Color(0xFFCDCDCD)]),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  checkMonth == true ? Image.asset('assets/images/clean.png') : Container(),
                  checkMonth == true ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          month,
                          style:checkMonth == true ? cardMonthTitle : deactivetedCardMonthTitle,
                        ),
                      ],
                    ),
                  ) :  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      month,
                      style:checkMonth == true ? cardMonthTitle : deactivetedCardMonthTitle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
