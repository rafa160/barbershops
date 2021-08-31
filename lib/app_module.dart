import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/app_widget.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/bloc/hour_bloc.dart';
import 'package:kabanas_barbershop/bloc/one_signal_bloc.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => UserBloc()),
    Bloc((i) => HourBloc()),
    Bloc((i) => DateBloc()),
    Bloc((i) => OneSignalBloc())
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}