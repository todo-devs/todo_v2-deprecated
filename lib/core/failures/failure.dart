import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure({this.message}) : super();

  @override
  List<Object> get props => [message];
}

class UssdCodesCacheFailure extends Failure {}

class UssdCodesServerFailure extends Failure {
  UssdCodesServerFailure(String message) : super(message: message);
}
