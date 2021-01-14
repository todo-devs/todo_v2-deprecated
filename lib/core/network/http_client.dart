import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:device_proxy/device_proxy.dart';

Future<Dio> httpClient() async {
  ProxyConfig proxyConfig = await DeviceProxy.proxyConfig;
  var dio = Dio();
  if (proxyConfig.isEnable) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return "PROXY ${proxyConfig.proxyUrl};";
      };
      client.connectionTimeout = Duration(seconds: 10);
    };
  }
  return dio;
}
