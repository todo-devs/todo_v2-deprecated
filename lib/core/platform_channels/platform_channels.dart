import 'package:flutter/services.dart';

final platform = const MethodChannel('com.cubanopensource.todo');

Future<bool> callTo(String number) async {
  return await platform.invokeMethod("callTo", number);
}
