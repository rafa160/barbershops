
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



