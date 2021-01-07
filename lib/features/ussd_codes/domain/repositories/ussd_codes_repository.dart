import 'package:todo/core/classes/classes.dart';
import 'package:todo/features/ussd_codes/domain/entities/ussd_item.dart';

abstract class IUssdCodesRepository {
  Future<Result<List<UssdItem>>> getUssdCodes();
}
