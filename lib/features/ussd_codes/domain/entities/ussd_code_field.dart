import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UssdCodeField extends Equatable {
  final String name;
  final String type;

  UssdCodeField({
    @required this.name,
    @required this.type,
  });

  List<Object> get props => [name, type];
}
