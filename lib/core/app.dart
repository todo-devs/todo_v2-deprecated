import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/route_manager.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:todo/core/i18n.dart';
import 'package:todo/features/todo/presentation/pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme.dark(),
        AppTheme.light(),
      ],
      child: ThemeConsumer(
        child: AppWidget(),
      ),
    );
  }
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Keys.app_name.tr(),
      theme: ThemeProvider.themeOf(context).data,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
      home: ExamplePage(),
    );
  }
}
