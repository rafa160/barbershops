import 'dart:async';

import 'package:kabanas_barbershop/bloc/one_signal_bloc.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';
import 'package:kabanas_barbershop/models/user_model.dart';

class EmployeeHoursBloc extends BlocBase {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  DocumentReference get _firestoreRef => FirebaseFirestore.instance.doc('users/$_employeeId');
  CollectionReference get registerReference => _firestoreRef.collection('hours');

  StreamController<bool> _streamController = StreamController<bool>.broadcast();
  Stream get loadingStream => _streamController.stream;
  Sink get loadingSink => _streamController.sink;

  Stream<List<HourModel>> hoursByEmployeeId;
  String _employeeId = '';

  String get employeeId => _employeeId;



  set employeeId(value) {
    _employeeId = value;
  }

  String _hourId = '';
  String get hourId => _hourId;

  set hourId(value) {
    _hourId = value;
  }

  String _oneSignalEmployeeId = '';
  String get oneSignalEmployeeId => _oneSignalEmployeeId;
  set oneSignalEmployeeId(value) {
    _oneSignalEmployeeId = value;
  }

  OneSignalBloc oneSignalBloc = new OneSignalBloc();

  void getListOfHoursByEmployeeId(String id, int weekNumber) {
    _employeeId = id;
    hoursByEmployeeId = registerReference.orderBy('hour', descending: false).where('week_day', isEqualTo: weekNumber).snapshots().map((event) => event.docs.map((e) => HourModel.fromDocument(e)).toList());
    print(hoursByEmployeeId.length);
  }

  Future<void> createRegisterInEmployeeHourColletion({UserModel userModel, HourModel hourModel, BuildContext context, String oneSignalId, DateTime timeStamp}) async {
    _streamController.add(true);
    if(hourModel.available == true){
      String day = await getStringDay(timeStamp);
      try {
        Map<String, dynamic> registerData = {
          "hour_id": hourId,
          "date": timeStamp,
          "user": userModel.toMap(),
          "check_date": day,
          "hour": hourModel.hour,
          "employee_id": _employeeId,
          "client_id": userModel.id
        };
        _oneSignalEmployeeId = oneSignalId;
        await  _fireStore.collection('registers').add(registerData);
        await oneSignalBloc.postEmployeeNotification(
            time: day,
            userName: userModel.name,
            hour: hourModel.hour,
            id:_oneSignalEmployeeId
        );
        await updateHour(hourId);
        _streamController.add(false);
        return;
      } catch (e) {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, 'Erro ao tentar marcar hor??rio');
        return;
      }
    } else {
      _streamController.add(false);
      ToastUtilsFail.showCustomToast(context, 'Voc?? n??o pode reservar mais de um hor??rio.');
      Get.back();
      return;
    }
  }

  Future<void> updateHour(String id) async {
    Map<String, dynamic> hourUpdated = {
      "available": false,
    };
    await registerReference.doc(id).update(hourUpdated);
  }

  Future<void> updateSchedulableItem(UserModel userModel) async {
    Map<String, dynamic> schedulableBool = {
      "schedulable": false,
    };
    await _fireStore.collection('users').doc(userModel.id).update(schedulableBool);
  }

  Future<String> getDay() async {
    DateTime _now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(_now);
    return formattedDate;
  }

  Future<String> getStringDay(DateTime time) async {
    String formattedDate = DateFormat('dd/MM/yyyy').format(time);
    return formattedDate;
  }

  Future<DateTime> setup() async {
    tz.initializeTimeZones();
    var fortaleza = tz.getLocation('America/Fortaleza');
    var now = tz.TZDateTime.now(fortaleza);
    return now;
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

}