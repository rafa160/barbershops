import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabanas_barbershop/models/user_model.dart';

class EmployeeBloc extends BlocBase {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  DocumentReference get _firestoreRef => FirebaseFirestore.instance.doc('users/');
  CollectionReference get registerReference => _firestoreRef.collection('hours');

  List<UserModel> employeeList = [];

  Future<List<UserModel>> getEmployeeList() async {
    final QuerySnapshot snapshot = await _fireStore.collection('users').where('role', isEqualTo: 1).get();
    return employeeList = snapshot.docs.map((e) => UserModel.fromDocument(e)).toList();
  }

}