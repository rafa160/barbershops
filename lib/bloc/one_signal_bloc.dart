import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:emojis/emojis.dart';
import 'package:kabanas_barbershop/helpers/one_signal_api.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalBloc extends BlocBase {

  OneSignalBloc() {
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(OneSignalApi.oneSignalAppId);
  }

  String _id ='';
  String email ='';
  String get id => _id;
  set id(value) {
    _id = value;
  }

  String _pushTokenId = '';
  String get pushTokenId => _pushTokenId;
  set pushTokenId(value) {
    _pushTokenId = value;
  }

  Future<void> postEmployeeNotification({String id, String hour, String userName}) async {
    var notification = OSCreateNotification(
        playerIds: [id],
        heading: 'Horário reservado às ${Emojis.twelveOClock}$hour',
        content: 'Olá o $userName agendou um horário com você. ${Emojis.partyPopper}${Emojis.confettiBall}',
    );
   await OneSignal.shared.postNotification(notification);
  }

  Future<String> getDeviceOneSignalId() async {
    final status = OneSignal.shared.getDeviceState();
    await status.then((value) {
      _id = value.userId;
    });
    print('$_id $email');
    return _id;
  }
}