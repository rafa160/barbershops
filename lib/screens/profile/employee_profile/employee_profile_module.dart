import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/bloc/employee_profile_bloc.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/employee_profile_page.dart';

class EmployeeProfileModule extends ModuleWidget {

  final UserModel userModel;

  EmployeeProfileModule(this.userModel);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => EmployeeProfileBloc())
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => EmployeeProfilePage(userModel: userModel);

  static Inject get to => Inject<EmployeeProfileModule>.of();
}