import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:todo/features/ussd_codes/presentation/bloc/bloc.dart';
import 'package:todo/features/ussd_codes/presentation/widgets/widgets.dart';

class UssdDataPage extends StatelessWidget {
  const UssdDataPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.I.get<UssdCodesBloc>()..add(GetLocalUssdCodesEvent()),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<UssdCodesBloc, UssdCodesState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case UssdCodesInitial:
                      return LoadingWidget();
                    case LoadingUssdCodes:
                      return LoadingWidget();
                    case LoadedUssdCodes:
                      final items =
                          _getDataItems((state as LoadedUssdCodes).items);

                      return Column(
                        children: items.map((UssdItem ussdItem) {
                          return UssdItemWidget(ussdItem: ussdItem);
                        }).toList(),
                      );
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

  List<UssdItem> _getDataItems(List<UssdItem> items) {
    return ((items.firstWhere(
      (element) => element.name.toLowerCase() == 'gestionar planes',
    ) as UssdCategory)
            .items
            .firstWhere(
              (element) => element.name.toLowerCase() == 'planes de datos',
            ) as UssdCategory)
        .items;
  }
}
