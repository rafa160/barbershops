import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';

class HourBloc extends BlocBase {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  DocumentReference get _firestoreRef => FirebaseFirestore.instance.doc('hours/$hourId');
  CollectionReference get registerReference => _firestoreRef.collection('register');

  StreamController<bool> _streamController = StreamController<bool>.broadcast();
  Stream get loadingStream => _streamController.stream;
  Sink get loadingSink => _streamController.sink;

  String _hourId = '';

  String get hourId => _hourId;

  set hourId(value) {
    _hourId = value;
  }

  Stream<List<HourModel>> hours;
  Stream<List<HourModel>> hoursByEmployeeId;
  List<HourModel> listOfHours =[];


  Future<DateTime> setup() async {
    tz.initializeTimeZones();
    var fortaleza = tz.getLocation('America/Fortaleza');
    var now = tz.TZDateTime.now(fortaleza);
    return now;
  }

  Future<String> getDay() async {
    DateTime _now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(_now);
    return formattedDate;
  }

  void getListOfHours() {
    hours = _fireStore
        .collection('hours')
        .orderBy('hour', descending: false)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => HourModel.fromDocument(e)).toList());
  }

  Future<void> createHourRegister({UserModel userModel, String hourId, HourModel hourModel, BuildContext context}) async {
    _streamController.add(true);
    if(hourModel.available == true){
      try {
        String day = await getDay();
        DateTime date = await setup();
        Map<String, dynamic> registerData = {
          "hour_id": hourId,
          "date": date,
          "user": userModel.toMap(),
          "check_date": day,
          "hour": hourModel.hour
        };
        await updateHour(hourId);
        // await updateSchedulableItem(userModel);
        await _fireStore.collection('registers').add(registerData);
        _streamController.add(false);
        return;
      } catch (e) {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, 'Erro ao tentar marcar horário');
        return;
      }
    } else {
      _streamController.add(false);
      ToastUtilsFail.showCustomToast(context, 'Você não pode reservar mais de um horário.');
      Get.back();
      return;
    }
  }

  Future<void> updateHour(String id) async {
    Map<String, dynamic> hourUpdated = {
      "available": false,
    };
    await _fireStore.collection('hours').doc(id).update(hourUpdated);
  }

  Future<void> updateSchedulableItem(UserModel userModel) async {
    Map<String, dynamic> schedulableBool = {
      "schedulable": false,
    };
    await _fireStore.collection('users').doc(userModel.id).update(schedulableBool);
  }

  Future<void> updateHoursAvailability(BuildContext context) async {
    _streamController.add(true);
    final QuerySnapshot snapshot = await _fireStore.collection('hours').where('available', isEqualTo: false).get();
    listOfHours = snapshot.docs.map((e) => HourModel.fromDocument(e)).toList();
    if(listOfHours.length <= 0) {
      _streamController.add(false);
      ToastUtilsSuccess.showCustomToast(context, 'Nenhum horário foi reservado hoje :(');
      return;
    } else {
      for(final hour in listOfHours) {
        Map<String, dynamic> hourUpdated = {
          "available": true,
        };
        await _fireStore.collection('hours').doc(hour.id).update(hourUpdated);
      }
    }
    _streamController.add(false);
    ToastUtilsSuccess.showCustomToast(context, 'Horários Atualizados para a agenda de amanhã');
  }

  Future<List<HourModel>> getListOfHoursFromTheStreamList() async {
    final QuerySnapshot snapshot = await _fireStore.collection('hours').orderBy('hour', descending: false).get();
    return listOfHours =
        snapshot.docs.map((e) => HourModel.fromDocument(e)).toList();
  }


}