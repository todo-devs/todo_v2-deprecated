import 'package:todo/core/classes/result.dart';
import 'package:todo/core/services/services.dart';
import 'package:todo/features/ussd_codes/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

class GetLocalUssdCodesHash implements IService<String, NoParams> {
  final IUssdCodesRepository repository;

  GetLocalUssdCodesHash({@required this.repository})
      : assert(repository != null);

  @override
  Future<Result<String>> call(NoParams params) {
    return repository.getLocalHash();
  }
}
