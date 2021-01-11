import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/failures/exceptions.dart';
import 'package:todo/features/ussd_codes/data/models/models.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';

abstract class IUssdCodesLocalDataSource {
  Future<List<UssdItem>> getUssdCodes();
  Future<String> getHash();
  Future<void> saveUssdCodes(List<UssdItem> items, String hash);
}

const USSD_CODES_KEY = 'config';
const USSD_CODES_HASH = 'hash';

class UssdCodesLocalDataSource implements IUssdCodesLocalDataSource {
  final SharedPreferences sharedPreferences;

  UssdCodesLocalDataSource({
    @required this.sharedPreferences,
  }) : assert(sharedPreferences != null);

  @override
  Future<List<UssdItem>> getUssdCodes() async {
    final jsonString = sharedPreferences.getString(USSD_CODES_KEY);

    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      jsonMap['type'] = 'category';

      return UssdCategoryModel.fromJson(jsonMap).items;
    } else
      throw UssdCodesCacheException();
  }

  @override
  Future<String> getHash() async {
    return sharedPreferences.getString(USSD_CODES_HASH);
  }

  @override
  Future<void> saveUssdCodes(List<UssdItem> items, String hash) async {
    final String data = json.encode({
      "items": items.map((e) {
        if (e.type == "code") {
          return (e as UssdCodeModel).toJson();
        } else if (e.type == "category") {
          return (e as UssdCategoryModel).toJson();
        }
      }).toList()
    });

    sharedPreferences.setString(USSD_CODES_KEY, data);
    sharedPreferences.setString(USSD_CODES_HASH, hash);
  }
}
