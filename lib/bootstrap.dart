import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/app.dart';
import 'package:snapframe/core/utils/app_logger.dart';

Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    appLogger.e(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      runApp(const ProviderScope(child: SnapApp()));
    },
    (error, stack) =>
        appLogger.e('uncaught error', error: error, stackTrace: stack),
  );
}
