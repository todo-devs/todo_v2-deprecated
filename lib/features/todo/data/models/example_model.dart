import 'package:json_annotation/json_annotation.dart';
import 'package:todo/features/todo/domain/entities/entities.dart';

part 'example_model.g.dart';

@JsonSerializable()
class ExampleModel extends ExampleEntity {
  final String exampleProperty;

  ExampleModel(this.exampleProperty) : super(exampleProperty);

  static ExampleModel fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleModelToJson(this);
}
