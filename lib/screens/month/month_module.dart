import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/screens/month/month_page.dart';

class MonthModule extends ModuleWidget {

  final String month;

  MonthModule(this.month);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => DateBloc())
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => MonthPage(month: month,);

  static Inject get to => Inject<MonthModule>.of();
}