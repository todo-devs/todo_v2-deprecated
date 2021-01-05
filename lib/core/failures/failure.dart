import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]) : super();

  @override
  List<Object> get props => this.properties;
}
