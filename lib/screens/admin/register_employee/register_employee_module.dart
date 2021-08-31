import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/bloc/category_bloc.dart';
import 'package:kabanas_barbershop/screens/admin/register_employee/register_employee_page.dart';

class RegisterEmployeeModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CategoryBloc())
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => RegisterEmployeePage();

  static Inject get to => Inject<RegisterEmployeeModule>.of();
}