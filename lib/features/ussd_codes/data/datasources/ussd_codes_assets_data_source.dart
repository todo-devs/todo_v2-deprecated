import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:todo/core/services/services.dart';
import 'package:todo/features/ussd_codes/data/models/models.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';

abstract class IUssdCodesAssetsDataSource {
  Future<List<UssdItem>> getUssdCodes();
}

const USSD_CODES = 'config/ussd_codes.json';

class UssdCodesAssetsDataSource implements IUssdCodesAssetsDataSource {
  final AssetsService assetsService;

  UssdCodesAssetsDataSource({
    @required this.assetsService,
  }) : assert(assetsService != null);

  @override
  Future<List<UssdItem>> getUssdCodes() async {
    final result = await assetsService(Params(filePath: USSD_CODES));

    final parsedJson = json.decode(result.data);

    parsedJson['type'] = 'category';

    return UssdCategoryModel.fromJson(parsedJson).items;
  }
}
