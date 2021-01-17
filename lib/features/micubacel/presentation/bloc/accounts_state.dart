part of 'accounts_bloc.dart';

abstract class AccountsState extends Equatable {
  const AccountsState();

  @override
  List<Object> get props => [];
}

class AccountsInitial extends AccountsState {}

class LoadingAccounts extends AccountsState {}

class LoadedAccounts extends AccountsState {
  final List<UserModel> accounts;

  LoadedAccounts({@required this.accounts});
}
