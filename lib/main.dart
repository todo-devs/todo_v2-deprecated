import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:todo/core/app.dart';
import 'package:todo/core/dependency_injection.dart';
import 'package:todo/core/translate_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  var delegate = await LocalizationDelegate.create(
    preferences: TranslatePreferences(),
    fallbackLocale: 'es',
    supportedLocales: ['es'],
  );
  runApp(LocalizedApp(delegate, App()));
}
