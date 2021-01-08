import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/network/network.dart';
import 'package:todo/core/services/assets_service.dart';
import 'package:todo/features/todo/data/repositories/repositories.dart';
import 'package:todo/features/todo/domain/repositories/repositories.dart';
import 'package:todo/features/todo/domain/services/services.dart';
import 'package:todo/features/todo/presentation/blocs/blocs.dart';
import 'package:todo/features/ussd_codes/data/datasources/datasources.dart';
import 'package:todo/features/ussd_codes/data/repositories/repositories.dart';
import 'package:todo/features/ussd_codes/domain/services/services.dart';
import 'package:todo/features/ussd_codes/presentation/bloc/bloc.dart';

class DependencyInjection {
  static Future<void> init() async {
    final I = GetIt.I;

    //! Blocs
    //* todo
    I.registerFactory<IExampleBloc>(
      () => ExampleBloc(I.get<IExampleService>()),
    );

    //* ussd_codes
    I.registerFactory(
      () => UssdCodesBloc(
        getAssetsUssdCodes: I(),
        getLocalUssdCodes: I(),
        getRemoteUssdCodes: I(),
        getLocalUssdCodesHash: I(),
        getRemoteUssdCodesHash: I(),
      ),
    );

    //! Services
    //* todo
    I.registerLazySingleton<IExampleService>(
      () => ExampleService(I.get<IExampleRepository>()),
    );

    //* ussd_codes
    I.registerLazySingleton(
      () => GetAssetsUssdCodes(
        repository: I(),
      ),
    );

    I.registerLazySingleton(
      () => GetLocalUssdCodes(
        repository: I(),
      ),
    );

    I.registerLazySingleton(
      () => GetRemoteUssdCodes(
        repository: I(),
      ),
    );

    I.registerLazySingleton(
      () => GetRemoteUssdCodesHash(
        repository: I(),
      ),
    );

    I.registerLazySingleton(
      () => GetLocalUssdCodesHash(
        repository: I(),
      ),
    );

    //! Repositories
    //* todo
    I.registerLazySingleton<IExampleRepository>(
      () => ExampleRepository(),
    );

    //* ussd_codes
    I.registerLazySingleton(
      () => UssdCodesRepository(
        ussdCodesAssetsDataSource: I(),
        ussdCodesLocalDataSource: I(),
        ussdCodesRemoteDataSource: I(),
      ),
    );

    //! Data Sources
    //* ussd_codes
    I.registerLazySingleton(
      () => UssdCodesAssetsDataSource(
        assetsService: I(),
      ),
    );

    I.registerLazySingleton(
      () => UssdCodesLocalDataSource(
        sharedPreferences: I(),
      ),
    );

    I.registerLazySingleton(
      () => UssdCodesRemoteDataSource(
        httpClient: I(),
      ),
    );

    //! Core
    //* ussd_codes
    I.registerLazySingleton(() => AssetsService());
    I.registerLazySingleton(() => httpClient());

    //! External
    final sharedPreferences = await SharedPreferences.getInstance();
    I.registerLazySingleton(
      () => sharedPreferences,
    );
  }
}
