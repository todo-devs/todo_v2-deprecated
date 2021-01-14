import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:meta/meta.dart';

class UssdCode extends UssdItem {
  final String code;
  final List<UssdCodeField> fields;

  UssdCode({
    @required String name,
    @required String description,
    @required String icon,
    @required String type,
    @required this.code,
    @required this.fields,
  }) : super(name: name, description: description, icon: icon, type: type);

  List<Object> get props => super.props..addAll([code, fields]);
}
