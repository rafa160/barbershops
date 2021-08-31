import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/screens/signup/sign_up_page.dart';

class SignUpModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => SignUpPage();

  static Inject get to => Inject<SignUpModule>.of();
}