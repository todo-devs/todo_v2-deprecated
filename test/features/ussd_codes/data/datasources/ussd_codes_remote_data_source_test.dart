import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/failures/exceptions.dart';
import 'package:todo/features/ussd_codes/data/datasources/datasources.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements DioForNative {}

void main() {
  UssdCodesRemoteDataSource ussdCodesLocalDataSource;
  MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    ussdCodesLocalDataSource = UssdCodesRemoteDataSource(
      httpClient: mockDio,
    );
  });

  group(
    '+ getUssdCodes:\n',
    () {
      test(
        '- Should return valid data from remote server',
        () async {
          final jsonString = fixtureUssdCodes();
          final jsonMap = json.decode(jsonString);
          final expectedString = json.encode(jsonMap);

          when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
            (_) async => Response(
              data: jsonMap,
              statusCode: 200,
            ),
          );

          final result = await ussdCodesLocalDataSource.getUssdCodes();

          verify(mockDio.get(USSD_CODES_REMOTE, options: anyNamed('options')));
          expect(result, equals(expectedString));
        },
      );

      test(
        '- Should throw a UssdCodesServerException',
        () async {
          // arrange
          when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
            (_) async => Response(
              data: 'Not found',
              statusCode: 404,
              request: RequestOptions(
                path: USSD_CODES_REMOTE,
              ),
            ),
          );

          // act
          final call = ussdCodesLocalDataSource.getUssdCodes;

          // assert
          expect(
              () => call(), throwsA(TypeMatcher<UssdCodesServerException>()));
        },
      );
    },
  );

  group(
    '+ getHash:\n',
    () {
      test(
        '- Should return valid data from remote server',
        () async {
          final jsonString = '{"hash": "test hash"}';
          final jsonMap = json.decode(jsonString);
          final expectedString = json.encode(jsonMap);

          when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
            (_) async => Response(
              data: jsonMap,
              statusCode: 200,
            ),
          );

          final result = await ussdCodesLocalDataSource.getHash();

          verify(mockDio.get(
            USSD_CODES_HASH_REMOTE,
            options: anyNamed('options'),
          ));

          expect(result, equals(expectedString));
        },
      );

      test(
        '- Should throw a UssdCodesServerException',
        () async {
          // arrange
          when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
            (_) async => Response(
              data: 'Not found',
              statusCode: 404,
              request: RequestOptions(
                path: USSD_CODES_REMOTE,
              ),
            ),
          );

          // act
          final call = ussdCodesLocalDataSource.getHash;

          // assert
          expect(
              () => call(), throwsA(TypeMatcher<UssdCodesServerException>()));
        },
      );
    },
  );
}
