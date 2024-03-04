import 'package:ledger/config/config.dart';
import 'package:logger/logger.dart';

class LoggerUtil {
  LoggerUtil.v(dynamic v) {
    if (GlobalConfig.isDebug) {
      Logger().v(v);
    }
  }

  /// 调试
  LoggerUtil.d(dynamic d) {
    if (GlobalConfig.isDebug) {
      Logger().d(d);
    }
  }

  /// 信息
  LoggerUtil.i(dynamic i) {
    if (GlobalConfig.isDebug) {
      Logger().i(i);
    }
  }

  /// 错误
  LoggerUtil.e(dynamic e, {dynamic tag}) {
    if (GlobalConfig.isDebug) {
      Logger().e(e);
    }
  }

  /// 警告
  LoggerUtil.w(dynamic w) {
    if (GlobalConfig.isDebug) {
      Logger().w(w);
    }
  }

  /// WTF
  LoggerUtil.f(dynamic f) {
    if (GlobalConfig.isDebug) {
      Logger().f(f);
    }
  }
}
