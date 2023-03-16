import 'dart:developer' as developer;

class Log {
  static const String _TAG_DEFAULT = "***LOG***";
  static bool _isDebug = false;

  static debug({bool isDebug = false}) {
    _isDebug = isDebug;
  }

  static d(String msg,
      {String TAG = _TAG_DEFAULT, bool showStackTrace = false}) {
    if (_isDebug) {
      developer.log(msg,
          name: TAG, stackTrace: showStackTrace ? StackTrace.current : null);
    }
  }
}
