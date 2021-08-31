import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabanas_barbershop/models/category_model.dart';

class CategoryBloc extends BlocBase {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<List<CategoryModel>> categoriesStreamList;

  void getStreamListOfCategories() {
    categoriesStreamList = _fireStore.collection('categories').orderBy('name', descending: false).snapshots().map(
        (event) =>
            event.docs.map((e) => CategoryModel.fromDocument(e)).toList());
    print(categoriesStreamList.first);
  }
}