import 'dart:convert';
import 'dart:io';

import 'package:todo/features/ussd_codes/data/models/models.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';

String fixture(String name) => File('./fixtures/$name').readAsStringSync();

String fixtureUssdCodes() =>
    File('../config/ussd_codes.json').readAsStringSync();

List<UssdItem> fixtureUssdCodesAsListUssdItem() {
  var jsonString = File('../config/ussd_codes.json').readAsStringSync();
  final jsonMap = json.decode(jsonString);
  jsonMap['type'] = 'category';
  return UssdCategoryModel.fromJson(jsonMap).items;
}
