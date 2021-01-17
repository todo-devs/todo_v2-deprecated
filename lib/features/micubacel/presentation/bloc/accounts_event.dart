part of 'accounts_bloc.dart';

abstract class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

class GetAccounts extends AccountsEvent {}
