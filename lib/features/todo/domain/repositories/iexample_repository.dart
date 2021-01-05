import 'package:todo/core/classes/classes.dart';
import 'package:todo/features/todo/domain/entities/entities.dart';

abstract class IExampleRepository {
  Future<Result<ExampleEntity>> getEntity();
}
