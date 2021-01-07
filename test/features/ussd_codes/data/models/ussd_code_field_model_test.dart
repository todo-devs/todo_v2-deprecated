import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/features/ussd_codes/data/models/models.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tUssdCodeFieldModel =
      UssdCodeFieldModel(name: 'telefono', type: 'phone_number');

  test(
    '- Should be a subclass of UssdCodeField entity',
    () async {
      // assert
      expect(tUssdCodeFieldModel, isA<UssdCodeField>());
    },
  );

  group(
    '+ fromJson"\n ',
    () {
      test(
        '- Should return a valid model from JSON',
        () {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('ussd_code_field.json'));

          // act
          final result = UssdCodeFieldModel.fromJson(jsonMap);

          // assert
          expect(result, tUssdCodeFieldModel);
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'Should return a JSON map containing the poper data',
        () {
          // act
          final result = tUssdCodeFieldModel.toJson();

          final expectedMap = {
            "name": "telefono",
            "type": "phone_number",
          };

          // assert
          expect(result, expectedMap);
        },
      );
    },
  );
}
