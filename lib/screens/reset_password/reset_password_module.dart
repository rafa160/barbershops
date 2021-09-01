import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/screens/reset_password/reset_password_page.dart';


class ResetPasswordModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ResetPasswordPage();

  static Inject get to => Inject<ResetPasswordModule>.of();
}