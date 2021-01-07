import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/classes/result.dart';
import 'package:todo/core/services/iservice.dart';

class AssetsService implements IService<String, Params> {
  @override
  Future<Result<String>> call(Params params) async {
    String data = await rootBundle.loadString(params.filePath);

    return Result(isOk: true, data: data);
  }
}

class Params extends Equatable {
  final String filePath;

  Params({@required this.filePath});

  List<Object> get props => [filePath];
}
