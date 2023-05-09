import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:logging/logging.dart';

final logger = AppLogger();

class AppLogger {
  AppLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      FirebaseCrashlytics.instance.log(record.message);
      print(
        '${record.level.name}: ${record.time}: ${userId ?? "<NO UID>"}: ${record.message}',
      );
    });
  }

  final logger = Logger('Tapped');
  String? userId;

  void setUserIdentifier(String? userId) {
    this.userId = userId;
    FirebaseCrashlytics.instance.setUserIdentifier(userId ?? '');
  }

  Future<void> reportPreviousSessionErrors() async {
    final crashed =
        await FirebaseCrashlytics.instance.didCrashOnPreviousExecution();
    if (crashed) {
      warning('App crashed on previous execution');
    } else {
      debug('App did not crash on previous execution');
    }
  }

  void debug(String message) {
    logger.fine(message);
  }

  void info(String message) {
    logger.info(message);
  }

  void warning(String message) {
    logger.warning(message);
  }

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    bool fatal = false,
  }) {
    logger.severe(message, error, stackTrace);
    try {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: fatal);
    } catch (e, s) {
      logger.severe(
        'Failed to report error to Firebase Crashlytics',
        e,
        s,
      );
    }
  }

  Trace createTrace(String name) {
    debug('create trace: $name');
    return FirebasePerformance.instance.newTrace(name);
  }
}
