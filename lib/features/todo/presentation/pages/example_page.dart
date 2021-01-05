import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:todo/core/i18n.dart';
import 'package:todo/features/todo/presentation/blocs/blocs.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<IExampleBloc>()..add(GetExampleEvent()),
      child: BlocConsumer<IExampleBloc, ExampleState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(Keys.app_name.tr()),
                centerTitle: true,
              ),
              drawer: Drawer(
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        DrawerHeader(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    width: 75,
                                    height: 75,
                                  ),
                                ),
                                Text(Keys.app_name.tr()),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CycleThemeIconButton(
                        icon: Icons.wb_sunny,
                      ),
                    ),
                  ],
                ),
              ),
              body: Builder(
                builder: (context) {
                  if (state is LoadingExampleState) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is LoadedExampleState) {
                    return Container(
                      child: Center(
                        child: Text(state.entity.exampleProperty),
                      ),
                    );
                  }
                  if (state is ErrorExampleState) {
                    return Container(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              floatingActionButton: Builder(
                builder: (context) {
                  if (state is LoadingExampleState) {
                    return Container();
                  }
                  return FloatingActionButton(
                    child: Icon(Icons.refresh),
                    onPressed: () {
                      BlocProvider.of<IExampleBloc>(context).add(
                        GetExampleEvent(),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
