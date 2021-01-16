import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/micubacel/presentation/bloc/bloc.dart';
import 'package:todo/features/micubacel/presentation/widgets/widgets.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';

class MiCubacelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return GetIt.I.get<MicubacelBloc>()..add(LoadMicubacelData());
      },
      child: Center(
        child: BlocBuilder<MicubacelBloc, MicubacelState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadedMicubacelData:
                final client = (state as LoadedMicubacelData).client;

                return MiCubacelInfo(client: client);
              case MiCubacelError:
                final message = (state as MiCubacelError).message;
                return Text(message);
              default:
                return LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
