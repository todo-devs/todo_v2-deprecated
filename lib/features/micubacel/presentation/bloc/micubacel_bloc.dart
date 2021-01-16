import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/micubacel/data/datasources/datasources.dart';

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
        final phone = (event as LoadMicubacelData).phone;
        final password = (event as LoadMicubacelData).password;
        final client = CubacelClient(phone: phone, password: password);
        await client.start();
        yield LoadedMicubacelData(client);
    }
  }
}
