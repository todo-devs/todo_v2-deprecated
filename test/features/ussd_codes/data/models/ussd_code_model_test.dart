import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/features/ussd_codes/data/models/models.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tUssdCodeModel = UssdCodeModel(
    name: "Transferir Saldo",
    description: "Transfiere tu saldo",
    icon: "mobile_screen_share",
    type: "code",
    code: "*234*1*{telefono}*{clave}*{cantidad}#",
    fields: [
      UssdCodeFieldModel(
        name: 'telefono',
        type: 'phone_number',
      ),
      UssdCodeFieldModel(
        name: 'cantidad',
        type: 'money',
      ),
      UssdCodeFieldModel(
        name: 'clave',
        type: 'key_number',
      )
    ],
  );

  test(
    '- Should be a subclass of UssdCode entity',
    () async {
      // assert
      expect(tUssdCodeModel, isA<UssdCode>());
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
              json.decode(fixture('ussd_code.json'));

          // act
          final result = UssdCodeModel.fromJson(jsonMap);

          // assert
          expect(result, tUssdCodeModel);
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
          final result = tUssdCodeModel.toJson();

          final expectedMap = {
            "name": "Transferir Saldo",
            "description": "Transfiere tu saldo",
            "icon": "mobile_screen_share",
            "type": "code",
            "fields": [
              {"name": "telefono", "type": "phone_number"},
              {"name": "cantidad", "type": "money"},
              {"name": "clave", "type": "key_number"}
            ],
            "code": "*234*1*{telefono}*{clave}*{cantidad}#"
          };

          // assert
          expect(result, expectedMap);
        },
      );
    },
  );
}
