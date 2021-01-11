import 'package:flutter_test/flutter_test.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';

void main() {
  final tUssdCodeMap = {
    "name": "Asterisco 99",
    "description": "Llamada con pago revertido",
    "icon": "call",
    "type": "code",
    "fields": [
      {"name": "telefono", "type": "phone_number"}
    ],
    "code": "*99{telefono}"
  };

  final tUssdCodeFields = [
    UssdCodeField(
      name: (tUssdCodeMap['fields'] as List)[0]['name'],
      type: (tUssdCodeMap['fields'] as List)[0]['type'],
    ),
  ];

  final tUssdCode = UssdCode(
    name: tUssdCodeMap['name'],
    description: tUssdCodeMap['description'],
    icon: tUssdCodeMap['icon'],
    type: tUssdCodeMap['type'],
    code: tUssdCodeMap['code'],
    fields: tUssdCodeFields,
  );

  test('- [props] should be include all properties', () {
    expect(
      tUssdCode.props,
      equals([
        tUssdCode.name,
        tUssdCode.description,
        tUssdCode.icon,
        tUssdCode.type,
        tUssdCode.code,
        tUssdCode.fields,
      ]),
    );
  });

  final tNewUssdCodeFields = [UssdCodeField(name: 'numero', type: 'telefono')];
  final tNewUssdCode = UssdCode(
    name: tUssdCode.name,
    description: tUssdCode.description,
    icon: tUssdCode.icon,
    type: tUssdCode.type,
    code: tUssdCode.code,
    fields: tNewUssdCodeFields,
  );

  test('- UssdCodes with different fields should not be equal', () {
    expect(tUssdCode, isNot(equals(tNewUssdCode)));
  });

  final tNewEqualUssdCode = UssdCode(
    name: tUssdCode.name,
    description: tUssdCode.description,
    icon: tUssdCode.icon,
    type: tUssdCode.type,
    code: tUssdCode.code,
    fields: [
      UssdCodeField(
        name: (tUssdCodeMap['fields'] as List)[0]['name'],
        type: (tUssdCodeMap['fields'] as List)[0]['type'],
      )
    ],
  );

  test('- UssdCode with equal fields should be equal', () {
    expect(tNewEqualUssdCode, equals(tUssdCode));
  });
}
