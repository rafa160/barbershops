
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> monthList = [
  'janeiro',
  'fevereiro',
  'março',
  'abril',
  'maio',
  'junho',
  'julho',
  'agosto',
  'setembro',
  'outubro',
  'novembro',
  'dezembro',
];

String removeSignalsFromNumber(String value) {
  String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
  return _onlyDigits;
}

String whatsAppUrl(String value) {
  String _phoneNumber = removeSignalsFromNumber(value);
  String _url = 'https://api.whatsapp.com/send?phone=55$_phoneNumber';
  return _url;
}

String ownerWhatsAppUrl() {
  String _url = 'https://api.whatsapp.com/send?phone=${558589582958}';
  return _url;
}

String getPhoneLaunch() {
  String _url = 'tel:${85989582958}';
  return _url;
}

String locationUrl() {
  return 'https://www.google.com/maps/search/?api=1&query=${'Rua Barão de Aracati'},${'2631'} - ${'Joaquim Távora'}, ${'Fortaleza'}';
}

bool getActualMonthColors(String month) {
  DateTime now1 = DateTime.now();
  String formattedDate = DateFormat('MMMM').format(now1);
  if(month == formattedDate) {
    return true;
  } else {
    return false;
  }
}

String getCategoryId(String text) {
  switch (text) {
    case 'Cabelo Fem.':
      return '27dp1J338nRcQYrSABbo';
    case 'Cabelo Masc.':
      return 'bgxTYPbFhDPCNxPr2s4S';
    case 'Depiladora Fem.':
      return 'IlC7KhMYvaMOQw2KPsuR';
    case 'Depiladora Masc.':
      return 'y24s19VFb1atSL6mGWHR';
    case 'Manicure':
      return '52P0Ap8fzJVHIlaVdkH1';
    case 'Manicure e Pedicure':
      return 'G1tsHB5LF9COY0pJaXK1';
    case 'Maquiagem':
      return 'cM8agvIEtoLbmbBcBCgU';
    case 'Pedicure':
      return 'Q0Wvs7GEMp2OgFtBlkUt';
    case 'Sobrancelhas':
      return 'C8kZWVxaghG1FtW9Ti1m';
    default:
      return 'bgxTYPbFhDPCNxPr2s4S';
  }
}

String getCategoryText(String id) {
  switch (id) {
    case '27dp1J338nRcQYrSABbo':
      return 'Cabelo Fem.';
    case 'bgxTYPbFhDPCNxPr2s4S':
      return 'Cabelo Masc.';
    case 'IlC7KhMYvaMOQw2KPsuR':
      return 'Depiladora Fem.';
    case 'y24s19VFb1atSL6mGWHR':
      return 'Depiladora Masc.';
    case '52P0Ap8fzJVHIlaVdkH1':
      return 'Manicure';
    case 'G1tsHB5LF9COY0pJaXK1':
      return 'Manicure e Pedicure';
    case 'cM8agvIEtoLbmbBcBCgU':
      return 'Maquiagem';
    case 'Q0Wvs7GEMp2OgFtBlkUt':
      return 'Pedicure';
    case 'C8kZWVxaghG1FtW9Ti1m':
      return 'Sobrancelhas';
    default:
      return 'Cabelo Masc.';
  }
}

String editType(String value) {
  return value = value.trim().replaceAll(':', '').replaceAll(':', '');
}

bool checkDateTimeFormatted(String hour) {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk:mm').format(now);
  String editedHour = editType(formattedDate);
  String modalEditedHour = editType(hour);
  int device = int.parse(editedHour);
  int myTime = int.parse(modalEditedHour);
  if(device >= myTime){
    return false;
  } else {
    return true;
  }
}

Map<String, int> monthsMap = {
  'janeiro': 1,
  'fevereiro': 2,
  'março':3,
  'abril': 4,
  'maio': 5,
  'junho': 6,
  'julho': 7,
  'agosto': 8,
  'setembro': 9,
  'outubro': 10,
  'novembro': 11,
  'dezembro': 12,
};

List<String> filteredMonthList = [];

Future<List<String>> getTheMonths(String month) async {
  int valueToBeRemoved = valueToRemove(month);
  print(valueToBeRemoved);
  monthList.removeRange(0, valueToBeRemoved);
  filteredMonthList.addAll(monthList);
  return filteredMonthList;
}

String getAmPmHour(String time) {

  return time.toLowerCase();
}

int valueToRemove(String month) {
  switch(month) {
    case 'janeiro':
      return 0;
    case 'fevereiro':
      return 1;
    case 'março':
      return 2;
    case 'abril':
      return 3;
    case 'maio':
      return 4;
    case 'junho':
      return 5;
    case 'julho':
      return 6;
    case 'agosto':
      return 7;
    case 'setembro':
      return 8;
    case 'outubro':
      return 9;
    case 'novembro':
      return 10;
    case 'dezembro':
      return 11;
  }
}

String getWeekDay(int weekDay) {
  switch(weekDay){
    case 1:
      return 'segunda-feira';
    case 2:
      return 'terça-feira';
    case 3:
      return 'quarta-feira';
    case 4:
      return 'quinta-feira';
    case 5:
      return 'sexta-feira';
    case 6:
      return 'sábado';
  }
}

String getAssetsImage(String id) {
  switch(id) {
    case '27dp1J338nRcQYrSABbo':
      return 'assets/images/woman.png';
    case '52P0Ap8fzJVHIlaVdkH1':
      return 'assets/images/maoepe.png';
    case 'C8kZWVxaghG1FtW9Ti1m':
      return 'assets/images/sobrancelha.png';
    case 'Djvfrh5bpiB895lxmeiL':
      return 'assets/images/hair_male.png';
    case 'G1tsHB5LF9COY0pJaXK1':
      return 'assets/images/maoepe.png';
    case 'IlC7KhMYvaMOQw2KPsuR':
      return 'assets/images/legs.png';
    case 'Q0Wvs7GEMp2OgFtBlkUt':
      return 'assets/images/maoepe.png';
    case 'bgxTYPbFhDPCNxPr2s4S':
      return 'assets/images/hair_male.png';
    case 'cM8agvIEtoLbmbBcBCgU':
      return 'assets/images/sobrancelha.png';
    case 'y24s19VFb1atSL6mGWHR':
      return 'assets/images/hair_male.png';
    default:
      return 'assets/images/hair_male.png';
  }
}

Tab mondayTab = new Tab(
  text: 'segunda-feira',
);

Tab tercaTab = new Tab(
  text: 'terça-feira',
);

Tab quartaTab = new Tab(
  text: 'quarta-feira',
);

Tab quintaTab = new Tab(
  text: 'quinta-feira',
);

Tab sextaTab = new Tab(
  text: 'sexta-feira',
);

Tab sabTab = new Tab(
  text: 'sábado',
);

Tab getDayTab(int number) {
  switch(number){
    case 1:
      return mondayTab;
    case 2:
      return tercaTab;
    case 3:
      return quartaTab;
    case 4:
      return quintaTab;
    case 5:
      return sextaTab;
    case 6:
      return sabTab;
  }
}

