import 'package:meta/meta.dart';
import 'package:todo/core/failures/failures.dart';
import 'package:todo/features/ussd_codes/data/datasources/datasources.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:todo/core/classes/classes.dart';
import 'package:todo/features/ussd_codes/domain/repositories/repositories.dart';

class UssdCodesRepository implements IUssdCodesRepository {
  final IUssdCodesAssetsDataSource ussdCodesAssetsDataSource;
  final IUssdCodesLocalDataSource ussdCodesLocalDataSource;
  final IUssdCodesRemoteDataSource ussdCodesRemoteDataSource;

  UssdCodesRepository({
    @required this.ussdCodesAssetsDataSource,
    @required this.ussdCodesLocalDataSource,
    @required this.ussdCodesRemoteDataSource,
  })  : assert(ussdCodesAssetsDataSource != null),
        assert(ussdCodesLocalDataSource != null),
        assert(ussdCodesRemoteDataSource != null);

  @override
  Future<Result<List<UssdItem>>> getAssetsUssdCodes() async {
    final result = await ussdCodesAssetsDataSource.getUssdCodes();
    return Result(isOk: true, data: result);
  }

  @override
  Future<Result<List<UssdItem>>> getLocalUssdCodes() async {
    try {
      final result = await ussdCodesLocalDataSource.getUssdCodes();
      return Result(isOk: true, data: result);
    } on UssdCodesCacheException {
      return Result(isOk: false, data: null, failure: UssdCodesCacheFailure());
    }
  }

  @override
  Future<Result<String>> getRemoteUssdCodes() async {
    try {
      final result = await ussdCodesRemoteDataSource.getUssdCodes();
      return Result(isOk: true, data: result);
    } on UssdCodesServerException catch (e) {
      return Result(
        isOk: false,
        data: null,
        failure: UssdCodesServerFailure(e.message),
      );
    }
  }

  @override
  Future<Result<String>> getLocalHash() async {
    final result = await ussdCodesLocalDataSource.getHash();
    return Result(isOk: true, data: result);
  }

  @override
  Future<Result<String>> getRemoteHash() async {
    try {
      final result = await ussdCodesRemoteDataSource.getHash();
      return Result(isOk: true, data: result);
    } on UssdCodesServerException catch (e) {
      return Result(
        isOk: false,
        data: null,
        failure: UssdCodesServerFailure(e.message),
      );
    }
  }

  @override
  Future<void> saveUssdCodes(List<UssdItem> items, String hash) {
    return ussdCodesLocalDataSource.saveUssdCodes(items, hash);
  }
}
