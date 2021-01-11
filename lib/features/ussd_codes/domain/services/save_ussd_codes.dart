import 'package:equatable/equatable.dart';
import 'package:todo/core/classes/result.dart';
import 'package:todo/core/services/services.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:todo/features/ussd_codes/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

class SaveUssdCodes implements IService<void, Params> {
  final IUssdCodesRepository repository;

  SaveUssdCodes({@required this.repository}) : assert(repository != null);

  @override
  Future<Result<void>> call(Params params) {
    return repository.saveUssdCodes(params.items, params.hash);
  }
}

class Params extends Equatable {
  final List<UssdItem> items;
  final String hash;

  Params({
    this.items,
    this.hash,
  });

  List<Object> get props => [items, hash];
}
