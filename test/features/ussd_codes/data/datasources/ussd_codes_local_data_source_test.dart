import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/failures/exceptions.dart';
import 'package:todo/features/ussd_codes/data/datasources/datasources.dart';
import 'package:todo/features/ussd_codes/data/models/models.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UssdCodesLocalDataSource ussdCodesLocalDataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    ussdCodesLocalDataSource = UssdCodesLocalDataSource(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group(
    '+ getUssdCodes:\n',
    () {
      test(
        '- Should return valid data from SharedPreferences',
        () async {
          final jsonString = fixtureUssdCodes();

          when(mockSharedPreferences.getString(any)).thenReturn(jsonString);

          final jsonExpected = json.decode(jsonString);

          final result = await ussdCodesLocalDataSource.getUssdCodes();

          final resultAsJson = {
            "items": result.map((e) {
              if (e.type == "code") {
                return (e as UssdCodeModel).toJson();
              } else if (e.type == "category") {
                return (e as UssdCategoryModel).toJson();
              }
            }).toList()
          };

          verify(mockSharedPreferences.getString(USSD_CODES_KEY));
          expect(resultAsJson, equals(jsonExpected));
        },
      );

      test(
        '- Should throw a UssdCodesCacheException when there is not a cached value',
        () async {
          // arrange
          when(mockSharedPreferences.getString(any)).thenReturn(null);

          // act
          final call = ussdCodesLocalDataSource.getUssdCodes;

          // assert
          expect(() => call(), throwsA(TypeMatcher<UssdCodesCacheException>()));
        },
      );
    },
  );

  group(
    '+ getHash:\n ',
    () {
      test(
        '- Should return valid data from SharedPreferences',
        () async {
          when(mockSharedPreferences.getString(any)).thenReturn('test hash');

          final result = await ussdCodesLocalDataSource.getHash();

          verify(mockSharedPreferences.getString(USSD_CODES_HASH));
          expect(result, equals('test hash'));
        },
      );
    },
  );

  group('+ saveUssdCodes:\n ', () {
    {
      test(
        '- Should call SharedPreferences to cache the data',
        () async {
          final jsonString = fixtureUssdCodes();

          when(mockSharedPreferences.getString(USSD_CODES_KEY))
              .thenReturn(jsonString);

          when(mockSharedPreferences.getString(USSD_CODES_HASH))
              .thenReturn('test hash');

          final result = await ussdCodesLocalDataSource.getUssdCodes();
          final hash = await ussdCodesLocalDataSource.getHash();

          final String data = json.encode({
            "items": result.map((e) {
              if (e.type == "code") {
                return (e as UssdCodeModel).toJson();
              } else if (e.type == "category") {
                return (e as UssdCategoryModel).toJson();
              }
            }).toList()
          });

          ussdCodesLocalDataSource.saveUssdCodes(result, hash);

          verify(
            mockSharedPreferences.setString(
              USSD_CODES_KEY,
              data,
            ),
          );

          verify(
            mockSharedPreferences.setString(
              USSD_CODES_HASH,
              'test hash',
            ),
          );
        },
      );
    }
  });
}
