import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabanas_barbershop/models/user_model.dart';

class RegisterModel {

  String id;
  String hourId;
  String hour;
  String employeeId;
  UserModel userModel;
  DateTime date;
  String checkDate;

  RegisterModel({this.id, this.hourId, this.userModel});

  RegisterModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    hourId = snapshot.get('hour_id');
    userModel = UserModel.fromMap(snapshot.get('user'));
    date = snapshot.get('date') != null
        ? DateTime.fromMillisecondsSinceEpoch(
        snapshot.get('date').millisecondsSinceEpoch)
        : null;
    checkDate = snapshot.get('check_date');
    hour = snapshot.get('hour');
    employeeId = snapshot.get('employee_id');
  }

}