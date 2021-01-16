part of 'micubacel_bloc.dart';

abstract class MicubacelEvent extends Equatable {
  const MicubacelEvent();

  @override
  List<Object> get props => [];
}

class LoadMicubacelData extends MicubacelEvent {
  final String phone;
  final String password;

  LoadMicubacelData({this.phone, this.password});
}
