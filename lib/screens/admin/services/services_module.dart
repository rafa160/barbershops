import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/bloc/price_bloc.dart';
import 'package:kabanas_barbershop/screens/admin/services/services_page.dart';

class ServicesModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => PriceBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => ServicesPage();

  static Inject get to => Inject<ServicesModule>.of();
}