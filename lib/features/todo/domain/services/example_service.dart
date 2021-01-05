import 'package:todo/core/classes/classes.dart';
import 'package:todo/features/todo/domain/entities/entities.dart';
import 'package:todo/features/todo/domain/repositories/repositories.dart';

abstract class IExampleService {
  final IExampleRepository repository;

  IExampleService(this.repository);

  Future<Result<ExampleEntity>> getEntity();
}

class ExampleService extends IExampleService {
  ExampleService(IExampleRepository repository) : super(repository);

  @override
  Future<Result<ExampleEntity>> getEntity() {
    return repository.getEntity();
  }
}
