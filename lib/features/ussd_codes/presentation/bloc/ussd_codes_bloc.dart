import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/services/iservice.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:todo/features/ussd_codes/domain/services/services.dart';

part 'ussd_codes_event.dart';

part 'ussd_codes_state.dart';

class UssdCodesBloc extends Bloc<UssdCodesEvent, UssdCodesState> {
  final GetAssetsUssdCodes getAssetsUssdCodes;
  final GetLocalUssdCodes getLocalUssdCodes;
  final GetRemoteUssdCodes getRemoteUssdCodes;
  final GetLocalUssdCodesHash getLocalUssdCodesHash;
  final GetRemoteUssdCodesHash getRemoteUssdCodesHash;
  final SaveUssdCodes saveUssdCodes;

  UssdCodesBloc({
    @required this.getAssetsUssdCodes,
    @required this.getLocalUssdCodes,
    @required this.getRemoteUssdCodes,
    @required this.getLocalUssdCodesHash,
    @required this.getRemoteUssdCodesHash,
    @required this.saveUssdCodes,
  })  : assert(getAssetsUssdCodes != null),
        assert(getLocalUssdCodes != null),
        assert(getRemoteUssdCodes != null),
        assert(getLocalUssdCodesHash != null),
        assert(getRemoteUssdCodesHash != null),
        assert(saveUssdCodes != null),
        super(UssdCodesInitial());

  @override
  Stream<UssdCodesState> mapEventToState(UssdCodesEvent event) async* {
    switch (event.runtimeType) {
      case InitialUssdCodesEvent:
        final resultLocalHash = await getLocalUssdCodesHash(NoParams());
        final resultRemoteHash = await getRemoteUssdCodesHash(NoParams());
        if (resultLocalHash.isOk &&
            resultRemoteHash.isOk &&
            (resultLocalHash.data == null ||
                resultLocalHash.data != resultRemoteHash.data)) {
          final resultRemote = await getRemoteUssdCodes(NoParams());
          if (resultRemote.isOk) {
            await saveUssdCodes(
              Params(
                items: resultRemote.data,
                hash: resultRemoteHash.data,
              ),
            );
          }
        }
        this.add(GetLocalUssdCodesEvent());
        break;
      case GetAssetsUssdCodesEvent:
        final result = await getAssetsUssdCodes(NoParams());
        if (result.isOk) {
          yield LoadedUssdCodes(items: result.data);
        } else {
          yield Error(message: result.failure.message);
        }
        break;
      case GetLocalUssdCodesEvent:
        yield LoadingUssdCodes();
        final result = await getLocalUssdCodes(NoParams());
        if (result.isOk) {
          yield LoadedUssdCodes(items: result.data);
        } else {
          this.add(GetAssetsUssdCodesEvent());
        }
        break;
    }
  }
}
