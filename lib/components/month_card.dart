import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';

class MonthCard extends StatelessWidget {

  final VoidCallback onTap;
  final String month;

  const MonthCard({Key key, this.month, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool checkMonth = getActualMonthColors(month);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          height: 30,
          width: 60,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:checkMonth == true ? [Colors.white, Colors.white70] : [Color(0xFFCDCDCD), Color(0xFFCDCDCD)]),
              borderRadius: BorderRadius.all(
                  Radius.circular(10)
              )
          ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                        month, style:checkMonth == true ? activeCardMonthTitle : deactivetedCardMonthTitle),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
