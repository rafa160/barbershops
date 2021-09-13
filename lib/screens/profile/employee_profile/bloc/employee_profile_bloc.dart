import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';
import 'package:kabanas_barbershop/models/register_model.dart';

class EmployeeProfileBloc extends BlocBase {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  DocumentReference get _firestoreRef => FirebaseFirestore.instance.doc('users/$_employeeId');
  CollectionReference get registerReference => _firestoreRef.collection('hours');

  StreamController<bool> _streamController = StreamController<bool>.broadcast();
  Stream get loadingStream => _streamController.stream;
  Sink get loadingSink => _streamController.sink;

  String _employeeId = '';
  String get employeeId => _employeeId;

  set employeeId(value) {
    _employeeId = value;
    print(_employeeId);
  }

  Stream<List<HourModel>> hoursByEmployeeId;

  List<HourModel> hoursList = [];
  List<HourModel> managedHoursList = [];

  List<RegisterModel> employeeRegisterList = [];

  Future<void> updateHoursAvailability({BuildContext context, String id}) async {
    _streamController.add(true);
    _employeeId = id;
    final QuerySnapshot snapshot = await registerReference.where('available', isEqualTo: false).get();
    hoursList = snapshot.docs.map((e) => HourModel.fromDocument(e)).toList();
    if(hoursList.length <= 0) {
      _streamController.add(false);
      ToastUtilsSuccess.showCustomToast(context, 'Nenhum horário foi reservado hoje :(');
      return;
    } else {
      for(final hour in hoursList) {
        Map<String, dynamic> hourUpdated = {
          "available": true,
        };
        await registerReference.doc(hour.id).update(hourUpdated);
      }
    }
    _streamController.add(false);
    ToastUtilsSuccess.showCustomToast(context, 'Horários Atualizados para a agenda de amanhã');
  }

  Future<String> getDay() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return formattedDate;
  }

  Future<List<RegisterModel>> getAdminRegisterList(String id) async {
    _employeeId = id;
    String date = await getDay();
    final QuerySnapshot snapshot =
    await _fireStore.collection('registers').where('check_date', isEqualTo:date).where('employee_id',isEqualTo: _employeeId).orderBy('hour', descending: false).get();
    employeeRegisterList =
        snapshot.docs.map((e) => RegisterModel.fromDocument(e)).toList();
    print(employeeRegisterList.length);
    return employeeRegisterList;
  }

  Future<List<HourModel>> getEmployeeHoursById() async {
    final QuerySnapshot snapshot = await registerReference.orderBy('hour', descending: false).get();
    managedHoursList = snapshot.docs.map((e) => HourModel.fromDocument(e)).toList();
    print(managedHoursList.length);
    return managedHoursList;
  }

  void getEmployeeHoursStreamListById() {
    hoursByEmployeeId = registerReference.orderBy('hour', descending: false).orderBy('week_day', descending: false).snapshots().map((event) => event.docs.map((e) => HourModel.fromDocument(e)).toList());
  }

  Future<void> deleteEmployeeHour({HourModel hourModel, BuildContext context}) async {
    await registerReference.doc(hourModel.id).delete();
    ToastUtilsSuccess.showCustomToast(context, 'Horários removido de sua agenda permanentemente. Atualize a página');
    Get.back();
  }

  Future<void> updateTheHourForTrue({String id, BuildContext context}) async {
    Map<String, dynamic> hourUpdated = {
      "available": true,
    };
    await registerReference.doc(id).update(hourUpdated);
    ToastUtilsSuccess.showCustomToast(context, 'Horário disponível novamente em sua agenda.');
    Get.back();
  }

}