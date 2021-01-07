import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/failures/exceptions.dart';

abstract class IUssdCodesRemoteDataSource {
  Future<String> getUssdCodes();
  Future<String> getHash();
}

const USSD_CODES_REMOTE = 'https://todo-devs.github.io/todo-json/config.json';
const USSD_CODES_HASH_REMOTE =
    'https://todo-devs.github.io/todo-json/hash.json';

class UssdCodesRemoteDataSource implements IUssdCodesRemoteDataSource {
  final Dio httpClient;

  UssdCodesRemoteDataSource({
    @required this.httpClient,
  }) : assert(httpClient != null);

  @override
  Future<String> getHash() async {
    return _getData(USSD_CODES_HASH_REMOTE);
  }

  @override
  Future<String> getUssdCodes() async {
    return _getData(USSD_CODES_REMOTE);
  }

  Future<String> _getData(String url) async {
    final response = await httpClient.get(
      url,
      options: Options(
        headers: {
          'Accept-Encoding': 'gzip, deflate, br',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final body = response.data as Map<String, dynamic>;
      return json.encode(body);
    } else {
      throw UssdCodesServerException(
        'Request failed: ${response.request.uri}\n'
        'StatusCode: ${response.statusCode}\n'
        'Body: ${response.data}',
      );
    }
  }
}
