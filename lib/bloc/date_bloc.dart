import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/calendar/calendar_module.dart';
import 'package:kabanas_barbershop/screens/employee/employee_module.dart';
import 'package:rxdart/rxdart.dart';

class DateBloc extends BlocBase {

  DateBloc() {
    getActualDayStream();
    getNextDayStream();
    getWeekDayAsStream();
    getCurrentMonthString();
  }

  DateTime now1 = DateTime.now();

  DateTime _now = DateTime.now();
  DateTime get now => _now;

  set now(value) {
    _now = value;
  }

  String _month = '';
  String get month => _month;
  set month(value) {
    _month = value;
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
      _streamMessage.sink.add('Hoje é $stringWeekDay, estamos fechados para atendimento ${Emojis.cryingFace}, bom fim de semana!');
    } else {
      _streamMessage.sink.add('Hoje é $stringWeekDay, a nossa agenda abre ás 09:00 horas.');
    }
  }

  Future<void> getWeekDayAsStream() async {
    weekDay = await getWeekDay();
    print(weekDay);
    _streamWeekDayController.add(weekDay);
  }

  Future<String> getCurrentMonthString() async {
    _month = DateFormat('MMMM').format(now1);
    print('$_month');
    return _month;
  }

  List<int> num = [];
  List<Tab> tabs = [];

  int i = 0;
  int dayCounter = 0;
  Tab get getTab => getDayTab(i);
  List<Widget> widget = [];
  List<DateTime> daysOfWeek = [];

  //clear the lists just to be sure of not add same info again when it calls

  Future<void> weekDays(String month, UserModel userModel) async {
    tabs.clear();
    widget.clear();
    num.clear();
    daysOfWeek.clear();

    int dayCounter = 0;
    int _weeksDayNumbers = await getWeekDay();

    for(int i = _weeksDayNumbers; i < 7; i ++) {
      final today = DateTime.now();

      final tomorrow = today.add(Duration(days: dayCounter));

      daysOfWeek.add(tomorrow);
      num.add(i);

      this.i = i;
      tabs.add(getTab);
      widget.add(
        CalendarModule(month, userModel, i,tomorrow),
      );
      dayCounter++;
    }
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