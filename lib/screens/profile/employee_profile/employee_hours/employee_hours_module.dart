import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/bloc/employee_profile_bloc.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/employee_hours/employee_hours_page.dart';

class EmployeeHoursModule extends ModuleWidget {

  final UserModel userModel;

  EmployeeHoursModule(this.userModel);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => EmployeeProfileBloc())
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => EmployeeHoursPage(userModel: userModel);

  static Inject get to => Inject<EmployeeHoursModule>.of();
}