import 'package:flutter/material.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:todo/features/ussd_codes/presentation/widgets/widgets.dart';

class UssdCodesWidget extends StatelessWidget {
  final List<UssdItem> items;

  const UssdCodesWidget(
    this.items, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: items.map((UssdItem ussdItem) {
          return UssdItemWidget(ussdItem: ussdItem);
        }).toList(),
      ),
    );
  }
}
