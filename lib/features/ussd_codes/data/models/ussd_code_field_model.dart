import 'package:meta/meta.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ussd_code_field_model.g.dart';

@JsonSerializable()
class UssdCodeFieldModel extends UssdCodeField {
  UssdCodeFieldModel({
    @required String name,
    @required String type,
  }) : super(name: name, type: type);

  factory UssdCodeFieldModel.fromJson(Map<String, dynamic> json) =>
      _$UssdCodeFieldModelFromJson(json);

  Map<String, dynamic> toJson() => _$UssdCodeFieldModelToJson(this);
}
