import 'package:flutter/material.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';
import 'package:todo/features/ussd_codes/presentation/pages/pages.dart';
import 'package:todo/core/i18n.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.blue,
          backwardsCompatibility: false,
          elevation: 0,
          centerTitle: true,
          title: Text(
            Keys.app_name.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        drawer: AppDrawer(),
        drawerEdgeDragWidth: 40.0,
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TabBar(
              controller: controller,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.blue,
              ),
              isScrollable: true,
              labelPadding: EdgeInsets.only(top: 0.5, bottom: 0.5),
              unselectedLabelColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.blue,
              tabs: [
                Container(
                  height: 70,
                  width: 75,
                  child: Icon(
                    Icons.phone,
                    size: 40,
                  ),
                ),
                Container(
                  height: 70,
                  width: 75,
                  child: Icon(
                    Icons.wifi,
                    size: 40,
                  ),
                ),
                Container(
                  height: 70,
                  width: 75,
                  child: Icon(
                    Icons.network_cell,
                    size: 40,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  UssdCodesPage(),
                  Center(child: Text('Wifi')),
                  Center(child: Text('Network')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
