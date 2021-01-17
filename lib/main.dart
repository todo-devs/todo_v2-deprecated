import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:todo/core/app.dart';
import 'package:todo/core/dependency_injection.dart';
import 'package:todo/core/translate_preferences.dart';
import 'package:todo/core/utils/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await DependencyInjection.init();
  var delegate = await LocalizationDelegate.create(
    preferences: TranslatePreferences(),
    fallbackLocale: 'es',
    supportedLocales: ['es'],
  );
  runApp(LocalizedApp(delegate, App()));
}
