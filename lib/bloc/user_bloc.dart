import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/bloc/one_signal_bloc.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/helpers/firebase_erros.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/login/login_module.dart';
import 'package:kabanas_barbershop/screens/main/main_module.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends BlocBase {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  DocumentReference get _firestoreRef => FirebaseFirestore.instance.doc('users/$_employeeId');
  CollectionReference get registerReference => _firestoreRef.collection('hours');
  FirebaseAuth firebaseAuth;

  UserCredential userCredential;
  UserModel user = new UserModel();
  // UserModel _internUser = new UserModel();
  OneSignalBloc _oneSignalBloc = new OneSignalBloc();

  bool _available = true;
  bool get available => _available;

  set available(value) {
    _available = value;
  }

  int _status = 2;
  int get status => _status;

  set status(value) {
     _status = value;
  }

  bool _schedulable = true;
  bool get schedulable => _schedulable;

  set schedulable(value) {
    _schedulable = value;
  }

  bool _admin = false;
  bool get admin => _admin;

  set admin(value) {
    _admin = value;
  }

  String _name = '';

  String get name => _name;

  set name(value) {
    _name = value;
  }

  String _category = '';
  String get category => _category;
  set category(value){
    _category = value;
  }

  String _employeeId = '';
  String get employeeId => _employeeId;
  set employeeId(value) {
    _employeeId = value;
  }

  String _oneSignalId = '';
  String get oneSignalId => _oneSignalId;
  set oneSignalId(value) {
    _oneSignalId = value;
  }

  StreamController<bool> _streamControllerBool = StreamController<bool>();
  Stream get schedulableStream => _streamController.stream;
  Sink get schedulableSink => _streamController.sink;

  String userName;
  String whatsApp;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _user$ = BehaviorSubject<UserModel>.seeded(null);

  final _userModel = BehaviorSubject<UserModel>();
  Stream<UserModel> get userModel => _userModel.stream;
  Sink<UserModel> get sinkUserModel => _userModel.sink;

  Sink<UserModel> get userIn => _user$.sink;

  StreamController<bool> _streamController = StreamController<bool>.broadcast();
  Stream get loginStream => _streamController.stream;
  Sink get loginSink => _streamController.sink;

  Future<UserCredential> signUp({String email, String password, name, String number,BuildContext context, bool available, bool admin, int status, String phone}) async {
    _streamController.add(true);
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      this.name = name;
      this.available = available;
      this.admin = admin;
      this.status = status;
      whatsApp = phone;
      _oneSignalId = await _oneSignalBloc.getDeviceOneSignalId();
      await _saveUserData();
      user = await getUserModel(id: userCredential.user.uid);

      await isLogged();

      _streamController.add(false);
      Get.offAll(() => MainModule());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _streamController.add(false);
      var error = getErrorString(e.code);
      if (e.code != null) {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, error);
      } else {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, error);
      }
    }
    return userCredential;
  }

  Future<UserCredential> signIn(
      String email, String password, BuildContext context) async {
    _streamController.add(true);
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      user = await getUserModel(id: userCredential.user.uid);
      _name = user.name;
      _available = user.available;
      _admin = user.admin;
      whatsApp = user.whatsApp;
      _schedulable = user.schedulable;
      _status = user.status.index;
      _category = user.category;

      if(user.oneSignalId == null || user.oneSignalId == ""){
        _oneSignalId = await _oneSignalBloc.getDeviceOneSignalId();
        Map<String, dynamic> userData = {
          "one_signal_id": _oneSignalId
        };
        await _fireStore.collection('users').doc(user.id).update(userData);
      }

      await _saveUserData();
      await isLogged();
      if(user.available == true) {
        _streamController.add(false);
        Get.offAll(() => MainModule());
      } else {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, 'error inesperado!');
      }

    } on FirebaseAuthException catch (e) {
      _streamController.add(false);
      var error = getErrorString(e.code);
      if (e.code != null) {
        ToastUtilsFail.showCustomToast(context, error);
      } else {
        ToastUtilsFail.showCustomToast(context, 'error');
      }
    }
  }

  Future _saveUserData() async {

    if (userCredential == null) {
      signOut();
    }

    Map<String, dynamic> userData = {
      'id': userCredential.user.uid,
      "email": userCredential.user.email,
      "name": name,
      "available": available,
      "admin": admin,
      "whats_app": whatsApp,
      "schedulable": schedulable,
      "role": status,
      "category": category ?? '',
      "one_signal_id": _oneSignalId ?? null
    };

    DocumentSnapshot userModel = await getUser(userId: userCredential.user.uid);
    if (userModel == null) {
      await _fireStore
          .collection('users')
          .doc(userCredential.user.uid)
          .set(userData);
    }
    await _saveUserLocally(userData);
    user = UserModel.fromJson(userData);
    userIn.add(UserModel.fromJson(userData));
  }

  Future signOut() async {
    await _auth.signOut();
    firebaseAuth = null;
    userIn.add(null);
    user = null;
    _streamController.add(null);
    _deleteUserLocally();
  }

  void _deleteUserLocally() async {
    var preference = await _prefs;
    preference.clear();
  }

  Future<bool> isLogged() async {
    var preference = await _prefs;
    return preference.get('users') != null;
  }

  Future<bool> _saveUserLocally(Map<String, dynamic> json) async {
    try {
      SharedPreferences share = await _prefs;
      share.setString('users', jsonEncode(json));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<DocumentSnapshot> getUser({String userId}) async {
    String id;
    if (userId == null) {
      var loggedUser = await loggedUserAsync();
      if (loggedUser == null) return null;
      id = loggedUser.id;
    } else {
      id = userId;
    }
    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection("users").doc(id).get();

    return documentSnapshot.exists ? documentSnapshot : null;
  }

  Future<UserModel> loggedUserAsync() async {
    return await get<UserModel>("users",
        construct: (v) => UserModel.fromJson(v));
  }

  Future get<S>(String key, {S Function(Map) construct}) async {
    try {
      SharedPreferences share = await _prefs;
      String value = share.getString(key);
      Map<String, dynamic> json = jsonDecode(value);
      if (construct == null) {
        return json;
      } else {
        return construct(json);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> getUserModel({String id}) async {
    try {
      if(id != null) {
        DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
        user = UserModel.fromDocument(documentSnapshot);
        _userModel.sink.add(user);
        print(user.toString());
        return user;
      } else {
        user = null;
        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signUpWithEmailPasswordAdminPastor({String email, String password, String name, String categoryName, String role,
      String id,String phone, BuildContext context, List<HourModel> hoursList}) async {
    try {
      _streamController.add(true);
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _employeeId = result.user.uid;
      String categoryId = getCategoryId(categoryName);
      Map<String, dynamic> userData = {
        'id': result.user.uid,
        "email": email,
        "name": name,
        "available": true,
        "admin": false,
        "whats_app": phone,
        "schedulable": true,
        "role": 1,
        "category": categoryId,
        "one_signal_id": null
      };
      await _fireStore.collection('users').doc(result.user.uid).set(userData);
      for(final hour in hoursList) {
        Map<String, dynamic> data = {
          "hour": hour.hour,
          "available": true
        };
        registerReference.add(data);
      }
      _streamController.add(false);
      ToastUtilsSuccess.showCustomToast(context, 'Funcionário Cadastrado');
      Get.back();
    } on FirebaseAuthException catch (e) {
      _streamController.add(false);
      var error = getErrorString(e.code);
      if (e.code != null) {
        ToastUtilsFail.showCustomToast(context, error);
      } else {
        ToastUtilsFail.showCustomToast(context, 'error');
      }
    }

  }

  Future<void> changeSchedulable(bool value) {
    _schedulable = value;
    _streamControllerBool.add(_schedulable);
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      _streamController.add(true);
      await _auth.sendPasswordResetEmail(email: email);
      ToastUtilsSuccess.showCustomToast(context, 'Solicitação enviada para o e-mail $email');
      _streamController.add(false);
      await Get.offAll(() => LoginModule());
    } on FirebaseAuthException catch (e) {
      _streamController.add(false);
      var error = getErrorString(e.code);
      if (e.code != null) {
        ToastUtilsFail.showCustomToast(context, error);
      } else {
        ToastUtilsFail.showCustomToast(context, error);
      }
    }

  }

  @override
  void dispose() {
    _user$.close();
    _userModel.close();
    super.dispose();
  }
}