import 'dart:io';

String fixture(String name) => File('./fixtures/$name').readAsStringSync();

String fixtureUssdCodes() =>
    File('../config/ussd_codes.json').readAsStringSync();
