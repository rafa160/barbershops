import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/user_model.dart';


class EmployeeCard extends StatelessWidget {

  final UserModel employee;
  final VoidCallback onTap;

  const EmployeeCard({Key key, this.employee, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String category = getCategoryText(employee.category);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          height: 40,
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
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(category,style: cardMonthTitle,),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Flexible(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                            employee.name, style: cardEmployeeSub),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
