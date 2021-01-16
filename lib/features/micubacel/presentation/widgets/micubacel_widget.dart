import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/micubacel/presentation/bloc/bloc.dart';
import 'package:todo/features/micubacel/presentation/pages/pages.dart';
import 'package:todo/features/micubacel/presentation/widgets/widgets.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';

class MiCubacelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return GetIt.I.get<MicubacelBloc>()..add(LoadMicubacelData());
      },
      child: BlocBuilder<MicubacelBloc, MicubacelState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadedMicubacelData:
              final client = (state as LoadedMicubacelData).client;

              return MiCubacelInfo(client: client);
            case MiCubacelError:
              final message = (state as MiCubacelError).message;
              return Text(message);
            case NotActiveUser:
              return Column(
                children: [
                  ListTile(
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
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      size: 32,
                    ),
                    onPressed: () {
                      BlocProvider.of<MicubacelBloc>(context)
                          .add(UpdateMicubacelData());
                    },
                  )
                ],
              );
            default:
              return LoadingWidget();
          }
        },
      ),
    );
  }
}
