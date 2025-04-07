import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(printer: PrettyPrinter(lineLength: 10));

final Logger loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0, lineLength: 10),
);

const String debugMessage = 'Active Debug Mode to See This Message';

// TODO(mahdiyar): create different classes

extension LogStringStyle on String {
  Logger get infoLogger => loggerNoStack..i(kDebugMode ? this : debugMessage);
  Logger get errorLogger =>
      logger..e(kDebugMode ? this : debugMessage, error: 'Error Message');
  Logger get warningLogger =>
      loggerNoStack..w(kDebugMode ? this : debugMessage);
  Logger get simpleLogger => loggerNoStack..t(kDebugMode ? this : debugMessage);
  Logger get debugLogger => loggerNoStack..d(kDebugMode ? this : debugMessage);
  Logger get testerLogger => loggerNoStack..f(kDebugMode ? this : debugMessage);
}

extension LogMapStyle on Map {
  Logger get infoLogger => loggerNoStack..i(kDebugMode ? this : debugMessage);
  Logger get errorLogger =>
      logger..e(kDebugMode ? this : debugMessage, error: 'Error Message');
  Logger get warningLogger =>
      loggerNoStack..w(kDebugMode ? this : debugMessage);
  Logger get simpleLogger => loggerNoStack..t(kDebugMode ? this : debugMessage);
}

extension LogListStyle on List {
  Logger get infoLogger => loggerNoStack..i(kDebugMode ? this : debugMessage);
  Logger get errorLogger =>
      logger..e(kDebugMode ? this : debugMessage, error: 'Error Message');
  Logger get warningLogger =>
      loggerNoStack..w(kDebugMode ? this : debugMessage);
  Logger get simpleLogger => loggerNoStack..t(kDebugMode ? this : debugMessage);
}
