import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart' as ft;
import 'package:flutter_translate_annotations/flutter_translate_annotations.dart';

part 'i18n.g.dart';

extension StringTranslate on String {
  String tr() {
    return ft.translate(this);
  }
}

changeLocale(BuildContext context, String language) {
  ft.changeLocale(context, language);
}

@TranslateKeysOptions(
  path: 'assets/i18n',
  caseStyle: CaseStyle.lowerCase,
)
class _$Keys // ignore: unused_element
{}
