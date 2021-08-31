import 'package:cloud_firestore/cloud_firestore.dart';

class PriceModel {

  String id;
  String description;
  String price;

  PriceModel({this.id, this.description, this.price});

  PriceModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    description = snapshot.get('description');
    price = snapshot.get('price');
  }

  PriceModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    price = json['price'];
  }
}