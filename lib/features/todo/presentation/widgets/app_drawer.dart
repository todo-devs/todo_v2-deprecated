import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:todo/core/i18n.dart';
import 'package:todo/features/todo/presentation/pages/pages.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

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
                      Text(
                        Keys.app_name.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              drawerTile(
                'Cuentas',
                Icons.account_circle_outlined,
                () {},
              ),
              drawerTile(
                'Ajustes',
                Icons.settings_outlined,
                () {
                  Navigator.pop(context);
                  Get.to(SettingsPage());
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: CycleThemeIconButton(icon: Icons.wb_sunny),
          ),
        ],
      ),
    );
  }

  Widget drawerTile(String title, IconData icon, Function onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
