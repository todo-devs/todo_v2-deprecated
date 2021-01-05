import 'package:get_it/get_it.dart';
import 'package:todo/features/todo/data/repositories/repositories.dart';
import 'package:todo/features/todo/domain/repositories/repositories.dart';
import 'package:todo/features/todo/domain/services/services.dart';
import 'package:todo/features/todo/presentation/blocs/blocs.dart';

class DependencyInjection {
  static Future<void> init() async {
    // Repositories
    GetIt.I.registerLazySingleton<IExampleRepository>(
      () => ExampleRepository(),
    );
    // Services
    GetIt.I.registerLazySingleton<IExampleService>(
      () => ExampleService(GetIt.I.get<IExampleRepository>()),
    );
    // Blocs
    GetIt.I.registerFactory<IExampleBloc>(
      () => ExampleBloc(GetIt.I.get<IExampleService>()),
    );
  }
}
