import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UssdItem extends Equatable {
  final String name;
  final String description;
  final String icon;
  final String type;

  UssdItem({
    @required this.name,
    @required this.description,
    @required this.icon,
    @required this.type,
  });

  List<Object> get props => [
        this.name,
        this.description,
        this.icon,
        this.type,
      ];
}
