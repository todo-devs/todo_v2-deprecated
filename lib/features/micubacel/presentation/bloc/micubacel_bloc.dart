import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selibrary/selibrary.dart';
import 'package:todo/features/micubacel/data/datasources/datasources.dart';
import 'package:todo/features/micubacel/data/models/models.dart';

part 'micubacel_event.dart';
part 'micubacel_state.dart';

class MicubacelBloc extends Bloc<MicubacelEvent, MicubacelState> {
  MicubacelBloc() : super(MicubacelInitial());

  @override
  Stream<MicubacelState> mapEventToState(
    MicubacelEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadMicubacelData:
        yield LoadingMicubacelData();
        final active = await UserModel.activeUser;

        if (active != null) {
          final client =
              CubacelClient(phone: active.phone, password: active.password);
          try {
            await client.start();
            yield LoadedMicubacelData(client);
          } on IException catch (e) {
            yield MiCubacelError(e.message);
          } catch (e) {
            print(e);
            yield MiCubacelError('El sitio micubacel.net está fuera de servicio temporalmente');
          }
        } else {
          yield NotActiveUser();
        }
    }
  }
}
