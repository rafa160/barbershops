import 'package:cloud_firestore/cloud_firestore.dart';

enum UserStatus {
  admin,
  employee,
  customer,
}

class UserModel {

   String id;
   String name;
   String email;
   String whatsApp;
   bool available;
   bool schedulable;
   bool admin;
   UserStatus status;
   String category;
   String oneSignalId;

  UserModel(
      { this.id,
       this.name,
       this.email,
       this.whatsApp,
       this.available,
       this.admin, this.schedulable, this.status, this.category, this.oneSignalId});

  UserModel.fromDocument(DocumentSnapshot snapshot) {
    Map item = snapshot.data();
    id = snapshot.id;
    email = item['email'];
    name = item['name'];
    available = item['available'];
    admin = item['admin'];
    whatsApp = item['whats_app'];
    schedulable = item['schedulable'];
    status = UserStatus.values[item['role'] as int];
    category = item['category'];
    oneSignalId = item['one_signal_id'];
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    available = json['available'];
    admin = json['admin'];
    whatsApp = json['whats_app'];
    schedulable = json['schedulable'];
    category = json['category'];
    status = UserStatus.values[json['role'] as int];
    oneSignalId = json['one_signal_id'];
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    whatsApp = map['whats_app'];
    schedulable = map['schedulable'];
    category = map['category'];
  }

  Map<String, dynamic> toMap() =>
      {'id': id, 'name': name, 'email': email, 'whats_app': whatsApp};

   String get statusText => getStatusText(status);

   static String getStatusText(UserStatus status) {
     switch (status) {
       case UserStatus.admin:
         return 'Administrador';
       case UserStatus.employee:
         return 'Funcionário';
       case UserStatus.customer:
         return 'Cliente';
       default:
         return 'Cliente';
     }
   }

  @override
  String toString() {
    return 'UserModel{id: $id, $name, $email, $whatsApp, $available, $admin, $schedulable, $category, $oneSignalId}';
  }
}