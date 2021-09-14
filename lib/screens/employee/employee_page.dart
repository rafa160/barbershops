import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/employee_card.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/calendar_employee_module.dart';
import 'package:kabanas_barbershop/screens/employee/bloc/employee_bloc.dart';
import 'package:kabanas_barbershop/screens/employee/employee_module.dart';

class EmployeePage extends StatefulWidget {

  final String month;

  const EmployeePage({Key key, this.month}) : super(key: key);

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {

  var employeeBloc = EmployeeModule.to.getBloc<EmployeeBloc>();
  var dateBloc = AppModule.to.getBloc<DateBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Escolha seu preferido',
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: CustomAnimatedContainer(
                  verticalOffset: 10,
                  horizontalOffset: 120,
                  milliseconds: 1200,
                  position: 2,
                  widget: Text(
                    'Escolha com quem você prefere agendar seu horário.', style: enterpriseText,
                  ),
                ),
              ),
              FutureBuilder(
                future: employeeBloc.getEmployeeList(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CustomColorCircularProgressIndicator(),
                      );
                    default:
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: employeeBloc.employeeList.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 3,
                        childAspectRatio: 4 / 3.6,
                      ),
                      itemBuilder: (context, index) {
                        UserModel employee = snapshot.data[index];
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1050),
                            child: SlideAnimation(
                              verticalOffset: 120,
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: EmployeeCard(
                                  onTap: () async {
                                    print(widget.month);
                                    await dateBloc.weekDays(widget.month, employee);
                                    await Get.to(() => CalendarEmployeeModule(widget.month, employee));
                                  },
                                  employee: employee,
                                ),
                              ),
                            ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
