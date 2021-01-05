import 'package:meta/meta.dart';
import 'package:todo/core/failures/failures.dart';

class Result<T> {
  final bool isOk;
  final Failure failure;
  final T data;

  Result({
    @required this.isOk,
    this.failure = const Failure(),
    @required this.data,
  });
}

class ResultVoid {
  final bool isOk;
  final Failure failure;

  ResultVoid({
    @required this.isOk,
    this.failure = const Failure(),
  });
}
