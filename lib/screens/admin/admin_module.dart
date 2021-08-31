import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/bloc/hour_bloc.dart';
import 'package:kabanas_barbershop/bloc/register_bloc.dart';
import 'package:kabanas_barbershop/screens/admin/admin_page.dart';

class AdminModule extends ModuleWidget {


  @override
  List<Bloc> get blocs => [
    Bloc((i) => HourBloc()),
    Bloc((i) => RegisterBloc())
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => AdminPage();

  static Inject get to => Inject<AdminModule>.of();
}