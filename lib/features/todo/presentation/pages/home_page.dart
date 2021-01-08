import 'package:flutter/material.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';
import 'package:todo/features/ussd_codes/presentation/pages/pages.dart';
import 'package:todo/core/i18n.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Keys.app_name.tr()),
        ),
        drawer: AppDrawer(),
        drawerEdgeDragWidth: 300.0,
        body: UssdCodesPage(),
      ),
    );
  }
}
