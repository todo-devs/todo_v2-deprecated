import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/micubacel/data/datasources/cubacel.dart';

class LoadClientException implements Exception {}

Future<CubacelClient> loadClient() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  String data = sharedPreferences.getString('micubacel_data');

  if (data == null) throw LoadClientException();
  if (data == '') throw LoadClientException();

  try {
    Map<String, dynamic> dataMap = json.decode(data);

    final client = CubacelClient();

    client.loadFromJson(dataMap);

    return client;
  } on Exception {
    throw LoadClientException();
  }
}

void saveClient(CubacelClient client) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  String data = json.encode(client.asJson);

  await sharedPreferences.setString('micubacel_data', data);
}
