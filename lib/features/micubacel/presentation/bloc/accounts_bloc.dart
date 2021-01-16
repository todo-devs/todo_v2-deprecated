import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/micubacel/data/models/models.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc() : super(AccountsInitial());

  @override
  Stream<AccountsState> mapEventToState(
    AccountsEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetAccounts:
        yield LoadingAccounts();
        final result = await UserModel.all;
        yield LoadedAccounts(accounts: result);

        break;
    }
  }
}
