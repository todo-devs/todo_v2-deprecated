part of 'micubacel_bloc.dart';

abstract class MicubacelState extends Equatable {
  const MicubacelState();

  @override
  List<Object> get props => [];
}

class MicubacelInitial extends MicubacelState {}

class LoadingMicubacelData extends MicubacelState {}

class MicubacelError extends MicubacelState {}

class LoadedMicubacelData extends MicubacelState {
  final CubacelClient client;

  LoadedMicubacelData(this.client);
}
