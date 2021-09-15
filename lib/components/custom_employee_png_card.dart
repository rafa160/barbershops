import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/user_model.dart';

class CustomEmployeePngCard extends StatelessWidget {

  final VoidCallback onTap;
  final UserModel employee;

  const CustomEmployeePngCard({Key key, this.onTap, this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String category = getCategoryText(employee.category);
    String urlImage = getAssetsImage(employee.category);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 168,
        width: 150,
        child: Card(
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
                      colors: [Color(0xff40dedf), Color(0xff0fb2ea)]),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(urlImage),
                 Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          employee.name,
                          style:cardMonthTitle,
                        ),
                        Text(
                          category,
                          style:cardEmployeeSub,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
