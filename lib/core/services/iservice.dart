import 'package:equatable/equatable.dart';
import 'package:todo/core/classes/classes.dart';

abstract class IService<Type, Params> {
  Future<Result<Type>> call(Params params);
}

class NoParams extends Equatable {
  List<Object> get props => [];
}
