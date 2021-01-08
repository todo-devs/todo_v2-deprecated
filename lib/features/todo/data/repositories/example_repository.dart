import 'package:todo/core/classes/result.dart';
import 'package:todo/core/failures/failures.dart';
import 'package:todo/features/todo/data/datasources/datasources.dart';
import 'package:todo/features/todo/domain/entities/example_entity.dart';
import 'package:todo/features/todo/domain/repositories/iexample_repository.dart';

class ExampleRepository extends IExampleRepository {
  @override
  Future<Result<ExampleEntity>> getEntity() async {
    try {
      final model = await getMockExampleModel();
      return Result(isOk: true, data: model);
    } catch (e) {
      return Result(
        isOk: false,
        failure: Failure(message: e.toString()),
        data: null,
      );
    }
  }
}
