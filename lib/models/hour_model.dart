import 'package:cloud_firestore/cloud_firestore.dart';

class HourModel {

  String id;
  String hour;
  bool available;

  HourModel({this.id, this.hour, this.available});

  HourModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    hour = snapshot.get('hour');
    available = snapshot.get('available');
  }

}