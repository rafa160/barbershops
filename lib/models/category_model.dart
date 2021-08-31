import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {

  String id;
  String name;

  CategoryModel({this.id, this.name});

  CategoryModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('name');
  }
}