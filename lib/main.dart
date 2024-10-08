import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qarz_daftar/app.dart';
import 'package:qarz_daftar/infrastructure/core/service_locator.dart';
import 'package:qarz_daftar/infrastructure/repo/storage_repository.dart';
import 'package:qarz_daftar/src/assets/constants/storage_keys.dart';
import 'package:qarz_daftar/src/assets/themes/theme_changer.dart';
import 'package:qarz_daftar/utils/bloc_logger.dart';
import 'package:qarz_daftar/utils/log_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await StorageRepository.getInstance();
  setupLocator();
  if (kDebugMode) {
    Bloc.observer = LogBlocObserver();
  }

  runApp(DependencyScope(
    initialModel: AppScope(
      themeMode: getTheme(StorageRepository.getString(StorageKeys.MODE)),
    ),
    child: const MyApp(),
  ));
}

ThemeMode getTheme(String mode) {
  Log.e(mode);
  switch (mode) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}
