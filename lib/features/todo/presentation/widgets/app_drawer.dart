import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:todo/core/i18n.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
