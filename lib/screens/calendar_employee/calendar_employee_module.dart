import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/bloc/employee_hours_bloc.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/calendar_employee_page.dart';

class CalendarEmployeeModule extends ModuleWidget {

  final String month;
  final UserModel employee;

  CalendarEmployeeModule(this.month, this.employee);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => DateBloc()),
    Bloc((i) => EmployeeHoursBloc())
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => CalendarEmployeePage(month: month, employee: employee);

  static Inject get to => Inject<CalendarEmployeeModule>.of();
}