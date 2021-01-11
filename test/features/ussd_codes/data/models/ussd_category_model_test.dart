import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/features/ussd_codes/data/models/models.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tUssdCategoryModel = UssdCategoryModel(
    name: "Adelantar Saldo",
    description: "Recarga con un adelanto de saldo",
    icon: "monetization_on",
    type: "category",
    items: [
      UssdCodeModel.fromJson({
        "name": "25 CUP",
        "description": "Adelanta con \$1.00 CUC de saldo",
        "icon": "monetization_on",
        "type": "code",
        "fields": [],
        "code": "*234*3*1*1#"
      }),
      UssdCodeModel.fromJson({
        "name": "50 CUP",
        "description": "Adelanta con \$2.00 CUC de saldo",
        "icon": "monetization_on",
        "type": "code",
        "fields": [],
        "code": "*234*3*1*2#"
      })
    ],
  );

  test(
    '- Should be a subclass of UssdCategory entity',
    () async {
      // assert
      expect(tUssdCategoryModel, isA<UssdCategory>());
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
              json.decode(fixture('ussd_category.json'));

          // act
          final result = UssdCategoryModel.fromJson(jsonMap);

          // assert
          expect(result, tUssdCategoryModel);
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
          final result = tUssdCategoryModel.toJson();

          final expectedMap = {
            "name": "Adelantar Saldo",
            "description": "Recarga con un adelanto de saldo",
            "icon": "monetization_on",
            "type": "category",
            "items": [
              {
                "name": "25 CUP",
                "description": "Adelanta con \$1.00 CUC de saldo",
                "icon": "monetization_on",
                "type": "code",
                "fields": [],
                "code": "*234*3*1*1#"
              },
              {
                "name": "50 CUP",
                "description": "Adelanta con \$2.00 CUC de saldo",
                "icon": "monetization_on",
                "type": "code",
                "fields": [],
                "code": "*234*3*1*2#"
              }
            ]
          };

          // assert
          expect(result, expectedMap);
        },
      );
    },
  );
}
