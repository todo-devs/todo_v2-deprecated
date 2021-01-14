import 'package:meta/meta.dart';
import 'package:todo/core/failures/exceptions.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'ussd_category_model.g.dart';

@JsonSerializable()
class UssdCategoryModel extends UssdCategory {
  UssdCategoryModel({
    @required String name,
    @required String description,
    @required String icon,
    @required String type,
    @required this.items,
  })  : assert(type == "category"),
        assert(items != null),
        super(
          name: name,
          description: description,
          icon: icon,
          type: type,
          items: items,
        );

  factory UssdCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$UssdCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UssdCategoryModelToJson(this);

  @JsonKey(fromJson: _fieldsFromJson, toJson: _fieldsToJson)
  final List<UssdItem> items;

  static List<UssdItem> _fieldsFromJson(List<dynamic> fieldList) =>
      fieldList.map((e) {
        if (e['type'] == 'code') {
          return UssdCodeModel.fromJson(e);
        } else if (e['type'] == 'category') {
          return UssdCategoryModel.fromJson(e);
        } else {
          throw ParseUssdCodeException(
              message: "Unknown type ${e['type']}", map: e);
        }
      }).toList();

  static List<Map<String, dynamic>> _fieldsToJson(List<UssdItem> fieldList) =>
      fieldList.map((e) {
        if (e.type == 'code') {
          return (e as UssdCodeModel).toJson();
        } else if (e.type == 'category') {
          return (e as UssdCategoryModel).toJson();
        } else {
          throw ParseUssdCodeException(message: "Unknown type ${e.type}");
        }
      }).toList();
}
