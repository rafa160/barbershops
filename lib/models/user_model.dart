import 'package:cloud_firestore/cloud_firestore.dart';

enum UserStatus {
  admin,
  employee,
  customer,
  master
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
    id = snapshot.id;
    email = snapshot.get('email');
    name = snapshot.get('name');
    available = snapshot.get('available');
    admin = snapshot.get('admin');
    whatsApp = snapshot.get('whats_app');
    schedulable = snapshot.get('schedulable');
    status = UserStatus.values[snapshot.get('role') as int];
    category = snapshot.get('category');
    oneSignalId = snapshot.get('one_signal_id');
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