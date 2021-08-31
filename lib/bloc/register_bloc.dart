import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kabanas_barbershop/models/register_model.dart';
import 'package:timezone/timezone.dart' as tz;

class RegisterBloc extends BlocBase {

  RegisterBloc() {
    getAdminRegisterList();
  }

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<RegisterModel> adminRegisterList = [];

  Future<String> getDay() async {
    // var fortaleza = tz.getLocation('America/Fortaleza');
    // var now = tz.TZDateTime.now(fortaleza);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return formattedDate;
  }

  Future<List<RegisterModel>> getAdminRegisterList() async {
    String date = await getDay();
    final QuerySnapshot snapshot =
        await _fireStore.collection('registers').where('check_date', isEqualTo:date).orderBy('hour', descending: false).get();
    adminRegisterList =
        snapshot.docs.map((e) => RegisterModel.fromDocument(e)).toList();
    print(adminRegisterList.length);
    return adminRegisterList;
  }

}