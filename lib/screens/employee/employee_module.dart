import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/screens/employee/bloc/employee_bloc.dart';
import 'package:kabanas_barbershop/screens/employee/employee_page.dart';

class EmployeeModule extends ModuleWidget {

  final String month;

  EmployeeModule(this.month);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => EmployeeBloc())
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => EmployeePage(month: month,);

  static Inject get to => Inject<EmployeeModule>.of();
}