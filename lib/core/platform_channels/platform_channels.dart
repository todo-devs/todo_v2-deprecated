import 'package:flutter/services.dart';

final platform = const MethodChannel('com.cubanopensource.todo');

//! Call
Future<bool> callTo(String number) async {
  return await platform.invokeMethod("callTo", number);
}

//! Show float widget
Future<bool> getShowWidgetPreference() async {
  return await platform.invokeMethod("getShowWidgetPreference");
}

Future<void> setTrueShowWidget() async {
  await platform.invokeMethod("setTrueShowWidget");
}

Future<void> setFalseShowWidget() async {
  await platform.invokeMethod("setFalseShowWidget");
}

//! Turn on/off wifi
Future<bool> getTurnOffWifiPreference() async {
  return await platform.invokeMethod("getTurnOffWifiPreference");
}

Future<void> setTrueTurnOffWifi() async {
  await platform.invokeMethod("setTrueTurnOffWifi");
}

Future<void> setFalseTurnOffWifi() async {
  await platform.invokeMethod("setFalseTurnOffWifi");
}

Future<void> turnOnWifi() async {
  await platform.invokeMethod("turnOnWifi");
}

Future<void> turnOffWifi() async {
  await platform.invokeMethod("turnOffWifi");
}
