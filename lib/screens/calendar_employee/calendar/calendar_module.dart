import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/bloc/employee_hours_bloc.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/calendar/calendar_page.dart';

class CalendarModule extends ModuleWidget {

  final String month;
  final UserModel employee;
  final int weekDayNumber;
  final DateTime dayOfWeek;

  CalendarModule(this.month, this.employee, this.weekDayNumber, this.dayOfWeek);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => DateBloc()),
    Bloc((i) => EmployeeHoursBloc())
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => CalendarPage(month: month, employee: employee, weekDayNumber: weekDayNumber, dayOfWeek: dayOfWeek,);

  static Inject get to => Inject<CalendarModule>.of();
}