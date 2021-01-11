import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/icons.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:todo/features/ussd_codes/domain/entities/ussd_code.dart';
import 'package:todo/features/ussd_codes/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/ussd_codes/presentation/widgets/widgets.dart';

class UssdCodeFormPage extends StatelessWidget {
  final UssdCode code;

  const UssdCodeFormPage({Key key, this.code}) : super(key: key);

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
          code.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => GetIt.I.get<UssdCodesBloc>(),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: UssdCodeForm(
                    code: code.code,
                    type: code.type,
                    fields: code.fields,
                    icon: Icon(
                      strIcons[code.icon],
                      size: 82,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
