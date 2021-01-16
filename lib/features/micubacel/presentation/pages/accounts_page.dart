import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/micubacel/presentation/bloc/accounts_bloc.dart';
import 'package:todo/features/micubacel/presentation/pages/account_form_page.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';

class CubacelAccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.blue,
        backwardsCompatibility: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cuentas MiCubacel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(CubacelAccountFormPage());
        },
      ),
      body: BlocProvider(
        create: (_) => GetIt.I.get<AccountsBloc>()..add(GetAccounts()),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              BlocBuilder<AccountsBloc, AccountsState>(
                  builder: (context, state) {
                switch (state.runtimeType) {
                  case AccountsInitial:
                    return LoadingWidget();
                  case LoadingAccounts:
                    return LoadingWidget();
                  case LoadedAccounts:
                    final accounts = (state as LoadedAccounts).accounts;
                    if (accounts.length == 0) {
                      return ListTile(
                        title: Text('Agregue una cuenta'),
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blue,
                          ),
                          height: 64,
                          width: 57,
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        trailing: Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          Get.to(CubacelAccountFormPage());
                        },
                      );
                    }
                    return Column(
                      children: accounts.map((account) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(account.name),
                              subtitle: Text(account.phone),
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.blue,
                                ),
                                height: 64,
                                width: 57,
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              trailing: account.active
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () async {
                                        await account.delete;
                                        BlocProvider.of<AccountsBloc>(context)
                                            .add(GetAccounts());
                                      }),
                              onTap: () async {
                                account.active = true;
                                await account.update;

                                BlocProvider.of<AccountsBloc>(context)
                                    .add(GetAccounts());
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  default:
                    throw Exception('Unknown state: ${state.runtimeType}');
                }
              }),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
