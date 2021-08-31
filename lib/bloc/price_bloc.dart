import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/models/price_model.dart';
import 'package:kabanas_barbershop/screens/admin/admin_module.dart';

class PriceBloc extends BlocBase {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  StreamController<bool> _streamController = StreamController<bool>.broadcast();
  Stream get loadingStream => _streamController.stream;
  Sink get loadingSink => _streamController.sink;

  Stream<List<PriceModel>> priceModelStream;

  List<PriceModel> priceList = [];


  void getListOfPrices() {
    priceModelStream =  _fireStore.collection('prices').snapshots().map((event) => event.docs.map((e) => PriceModel.fromDocument(e)).toList());
  }

  Future<List<PriceModel>> getPriceList() async {
    final QuerySnapshot snapshot = await _fireStore.collection('prices').get();
    return priceList =
        snapshot.docs.map((e) => PriceModel.fromDocument(e)).toList();
  }

  Future<void> editPriceModel({String description, String price, String priceId, BuildContext context}) async {
    _streamController.add(true);
    Map<String, dynamic> data = {
      "description": description,
      "price": price
    };
    await _fireStore.collection('prices').doc(priceId).update(data);
    _streamController.add(false);
    Get.back();
    ToastUtilsSuccess.showCustomToast(context, 'Serviço Atualizado');
  }

  Future<void> createPriceModel({String description, String price, BuildContext context}) async {
    _streamController.add(true);
    Map<String, dynamic> data = {
      "description": description,
      "price": price
    };
    await _fireStore.collection('prices').add(data);
    _streamController.add(false);
    Get.back();
    ToastUtilsSuccess.showCustomToast(context, 'Serviço Criado');
  }

  Future<void> deletePriceModel({String id, BuildContext context}) async {
    await _fireStore.collection('prices').doc(id).delete();
    Get.back();
    ToastUtilsSuccess.showCustomToast(context, 'Serviço Deletado');
  }

}