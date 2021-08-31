import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/screens/employee/employee_module.dart';
import 'package:rxdart/rxdart.dart';

class DateBloc extends BlocBase {

  DateBloc() {
    getActualDayStream();
    getNextDayStream();
    getWeekDayAsStream();
  }

  DateTime now1 = DateTime.now();

  DateTime _now = DateTime.now();
  DateTime get now => _now;

  set now(value) {
    _now = value;
  }

  final _streamActualDay = BehaviorSubject<String>();
  Stream<String> get streamActualDay => _streamActualDay.stream;
  Sink<String> get sinkActualDay => _streamActualDay.sink;

  final _streamMessage = BehaviorSubject<String>();
  Stream<String> get streamMessage => _streamMessage.stream;
  Sink<String> get sinkStreamMessage => _streamMessage.sink;

  final _streamTomorrowDay = BehaviorSubject<String>();
  Stream<String> get streamTomorrowDay => _streamTomorrowDay.stream;
  Sink<String> get sinkTomorrowDay => _streamTomorrowDay.sink;

  int weekDay = 0;
  final _streamWeekDayController = BehaviorSubject<int>();
  Stream<int> get outIntWeekDay => _streamWeekDayController.stream;

  Future<bool> getCurrentMonth(String month, BuildContext context) async {
    String formattedDate = DateFormat('MMMM').format(now1);
    print('$formattedDate $month');
    if(month == formattedDate) {
      Get.to(() => EmployeeModule(month));
      return true;
    } else {
      ToastUtilsFail.showCustomToast(context, 'Agenda fechada para esse mês');
      return false;
    }
  }

  bool getActualMonthColors(String month) {
    String formattedDate = DateFormat('MMMM').format(now1);
    if(month == formattedDate) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> getWeekDay() async {
    _now = now;
    return _now.weekday;
  }

  void getActualDayStream() {
    String formattedDate = DateFormat('dd/MM/yyyy').format(_now);
    _streamActualDay.sink.add(formattedDate);
  }

  void getNextDayStream() {
    DateTime tomorrow = DateTime(_now.year, _now.month, _now.day +1);
    String formattedDate = DateFormat('dd').format(tomorrow);
    _streamTomorrowDay.sink.add(formattedDate);
  }

  Future<void> getMessageForEachDay() async {
    int weekDay = await getWeekDay();
    String stringWeekDay = DateFormat('EEEE').format(_now);
    if(weekDay == 7) {
      _streamMessage.sink.add('Hoje é $stringWeekDay, estamos fechados para atendimento, bom fim de semana!');
    } else {
      _streamMessage.sink.add('Hoje é $stringWeekDay, a nossa agenda abre ás 09:00 horas.');
    }
  }

  Future<void> getWeekDayAsStream() async {
    weekDay = await getWeekDay();
    print(weekDay);
    _streamWeekDayController.add(weekDay);
  }

  @override
  void dispose() {
    _streamTomorrowDay.close();
    _streamMessage.close();
    _streamTomorrowDay.close();
    _streamActualDay.close();
    super.dispose();
  }
}