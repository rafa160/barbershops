import 'package:cloud_firestore/cloud_firestore.dart';

class HourModel {

  String id;
  String hour;
  int weekDay;
  bool available;

  HourModel({this.id, this.hour, this.available, this.weekDay});

  HourModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    hour = snapshot.get('hour');
    available = snapshot.get('available');
    weekDay = snapshot.get('week_day');
  }

}