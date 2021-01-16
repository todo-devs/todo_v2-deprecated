import 'package:selibrary/selibrary.dart';

class CubacelClient extends ICubacelClient {
  final phone;
  final password;

  CubacelClient({this.phone, this.password});

  Future<void> start() async {
    await login(phone, password);
    await loadMyAccount();
  }
}
