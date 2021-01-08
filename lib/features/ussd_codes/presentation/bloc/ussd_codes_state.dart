part of 'ussd_codes_bloc.dart';

abstract class UssdCodesState extends Equatable {
  const UssdCodesState();

  @override
  List<Object> get props => [];
}

class UssdCodesInitial extends UssdCodesState {}

class LoadingUssdCodes extends UssdCodesState {}

class LoadingUssdHash extends UssdCodesState {}

class LoadedUssdCodes extends UssdCodesState {
  final List<UssdItem> items;

  LoadedUssdCodes({
    @required this.items,
  });

  @override
  List<Object> get props => [items];
}

class LoadedUssdHash extends UssdCodesState {
  final String hash;

  LoadedUssdHash({
    @required this.hash,
  });

  @override
  List<Object> get props => [hash];
}

class Error extends UssdCodesState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
