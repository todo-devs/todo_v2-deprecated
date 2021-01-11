import 'package:meta/meta.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'ussd_code_model.g.dart';

@JsonSerializable()
class UssdCodeModel extends UssdCode {
  UssdCodeModel({
    @required String name,
    @required String description,
    @required String icon,
    @required String type,
    @required String code,
    @required this.fields,
  })  : assert(type == "code"),
        assert(fields != null),
        super(
          name: name,
          description: description,
          icon: icon,
          type: type,
          code: code,
          fields: fields,
        );

  factory UssdCodeModel.fromJson(Map<String, dynamic> json) =>
      _$UssdCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$UssdCodeModelToJson(this);

  @JsonKey(fromJson: _fieldsFromJson, toJson: _fieldsToJson)
  final List<UssdCodeFieldModel> fields;

  static List<UssdCodeFieldModel> _fieldsFromJson(List<dynamic> fieldList) =>
      fieldList.map((e) => UssdCodeFieldModel.fromJson(e)).toList();

  static List<Map<String, dynamic>> _fieldsToJson(
          List<UssdCodeFieldModel> fieldList) =>
      fieldList.map((e) => e.toJson()).toList();
}
