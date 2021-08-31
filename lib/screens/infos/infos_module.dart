import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/bloc/price_bloc.dart';
import 'package:kabanas_barbershop/screens/infos/infos_page.dart';

class InfosModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => PriceBloc())
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => InfosPage();

  static Inject get to => Inject<InfosModule>.of();
}