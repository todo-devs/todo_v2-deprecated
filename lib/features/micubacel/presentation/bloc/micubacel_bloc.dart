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
          try {
            final client = await loadClient();
            yield LoadedMicubacelData(client);
          } on LoadClientException {
            try {
              final client =
                  CubacelClient(phone: active.phone, password: active.password);
              await client.start();
              yield LoadedMicubacelData(client);
              saveClient(client);
            } on IException catch (e) {
              print(e.message);
              yield MiCubacelError('No se pudo acceder a micubacel.net');
            } catch (e) {
              print(e);
              this.add(LoadMicubacelData());
            }
          }
        } else {
          yield NotActiveUser();
        }
        break;
      case UpdateMicubacelData:
        yield LoadingMicubacelData();
        final active = await UserModel.activeUser;
        if (active != null) {
          try {
            final client =
                CubacelClient(phone: active.phone, password: active.password);
            await client.start();
            yield LoadedMicubacelData(client);
            saveClient(client);
          } on IException catch (e) {
            print(e.message);
            yield MiCubacelError('No se pudo acceder a micubacel.net');
          } catch (e) {
            print(e);
            this.add(LoadMicubacelData());
          }
        } else {
          yield NotActiveUser();
        }
        break;
    }
  }
}
