import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/utils/icons.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:todo/features/ussd_codes/presentation/bloc/bloc.dart';
import 'package:todo/features/ussd_codes/presentation/widgets/widgets.dart';

class UssdCategoryPage extends StatelessWidget {
  final UssdCategory category;

  UssdCategoryPage(this.category) : assert(category != null);

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
          category.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => GetIt.I.get<UssdCodesBloc>(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Hero(
                tag: category.name + category.description,
                child: Icon(
                  strIcons[category.icon],
                  size: 82,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.blue,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              UssdCodesWidget(category.items),
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
