import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todo/features/micubacel/presentation/widgets/widgets.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';
import 'package:todo/features/ussd_codes/presentation/pages/pages.dart';
// import 'package:todo/core/i18n.dart';

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
    controller = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.75;
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
            'TODO',
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
              height: 15,
            ),
            Expanded(
              child: Column(
                children: [
                  AppTabBar(controller: controller),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        UssdCodesPage(),
                        UssdDataPage(),
                        Center(child: Text('Network')),
                        MiCubacelWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
