part of 'micubacel_bloc.dart';

abstract class MicubacelEvent extends Equatable {
  const MicubacelEvent();

  @override
  List<Object> get props => [];
}

class LoadMicubacelData extends MicubacelEvent {}

class UpdateMicubacelData extends MicubacelEvent {}
