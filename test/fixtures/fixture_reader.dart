import 'dart:io';

String fixture(String name) => File('./fixtures/$name').readAsStringSync();
