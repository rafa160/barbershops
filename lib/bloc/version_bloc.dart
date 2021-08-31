import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

class VersionBloc extends BlocBase {

  VersionBloc() {
    versionApp();
    getFreeTrialDuration();
  }

  final _version$ = BehaviorSubject<String>.seeded("0.0.0");
  Stream<String> get streamVersion$ => _version$.stream;
  Sink get sinkVersion => _version$.sink;

  final _freeDays$ = BehaviorSubject<int>();
  Stream<int> get freeDays$ => _freeDays$.stream;
  Sink<int> get sinkFreeDays$ => _freeDays$.sink;

  var _endFreeTrial = DateTime.utc(2021, 10, 01);

  Future<int> getFreeTrialDuration() async {
    var _now = DateTime.now();
    Duration _differenceDays = _endFreeTrial.difference(_now);
    _freeDays$.sink.add(_differenceDays.inDays);
    return _differenceDays.inDays;
  }

  void versionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    sinkVersion.add('${packageInfo.version} (${packageInfo.buildNumber})');
  }

  @override
  void dispose() {
    super.dispose();
    _freeDays$.close();
    _version$.close();
  }
}