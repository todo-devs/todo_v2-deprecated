import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';
import 'package:todo/features/ussd_codes/presentation/bloc/bloc.dart';

class UssdCodesPage extends StatelessWidget {
  const UssdCodesPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.I.get<UssdCodesBloc>()..add(GetLocalUssdCodesEvent()),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              BlocBuilder<UssdCodesBloc, UssdCodesState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case UssdCodesInitial:
                      return LoadingWidget();
                    case LoadingUssdCodes:
                      return LoadingWidget();
                    case LoadedUssdCodes:
                      return Text('DONE');
                    default:
                      throw Exception('Unknown state: ${state.runtimeType}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
