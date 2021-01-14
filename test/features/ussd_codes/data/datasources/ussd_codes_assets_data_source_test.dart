import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/classes/classes.dart';
import 'package:todo/core/services/assets_service.dart';
import 'package:todo/features/ussd_codes/data/datasources/datasources.dart';
import 'package:todo/features/ussd_codes/data/models/models.dart';
import 'package:todo/features/ussd_codes/data/models/ussd_code_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockAssetsService extends Mock implements AssetsService {}

void main() {
  UssdCodesAssetsDataSource ussdCodesAssetsDataSource;
  MockAssetsService mockAssetsService;

  setUp(() {
    mockAssetsService = MockAssetsService();
    ussdCodesAssetsDataSource = UssdCodesAssetsDataSource(
      assetsService: mockAssetsService,
    );
  });

  test(
    '- getUssdCodes',
    () async {
      final jsonString = fixtureUssdCodes();

      when(mockAssetsService.call(any)).thenAnswer(
        (_) async => Result(
          isOk: true,
          data: jsonString,
        ),
      );

      final jsonExpected = json.decode(jsonString);

      final result = await ussdCodesAssetsDataSource.getUssdCodes();

      final resultAsJson = {
        "items": result.map((e) {
          if (e.type == "code") {
            return (e as UssdCodeModel).toJson();
          } else if (e.type == "category") {
            return (e as UssdCategoryModel).toJson();
          }
        }).toList()
      };

      verify(mockAssetsService(Params(filePath: USSD_CODES)));
      expect(resultAsJson, equals(jsonExpected));
    },
  );
}
