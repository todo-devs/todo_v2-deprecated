part of 'ussd_codes_bloc.dart';

abstract class UssdCodesEvent extends Equatable {
  const UssdCodesEvent();

  @override
  List<Object> get props => [];
}

class GetAssetsUssdCodesEvent extends UssdCodesEvent {}

class GetLocalUssdCodesEvent extends UssdCodesEvent {}

class GetRemoteUssdCodesEvent extends UssdCodesEvent {}

class GetLocalUssdCodesHashEvent extends UssdCodesEvent {}

class GetRemoteUssdCodesHashEvent extends UssdCodesEvent {}

class SaveUssdCodesEvent extends UssdCodesEvent {
  final List<UssdItem> items;
  final String hash;

  SaveUssdCodesEvent({
    this.items,
    this.hash,
  });
}

class CallToEvent extends UssdCodesEvent {
  final String number;

  CallToEvent(this.number) : assert(number != null);
}
