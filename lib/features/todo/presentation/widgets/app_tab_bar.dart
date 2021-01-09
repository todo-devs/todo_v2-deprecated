import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.blue,
      ),
      isScrollable: true,
      labelPadding: EdgeInsets.only(top: 0.5, bottom: 0.5),
      unselectedLabelColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.blue,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      tabs: [
        Container(
          height: 64,
          width: 68,
          child: Icon(
            Icons.phone_android_rounded,
            size: 38,
          ),
        ),
        Container(
          height: 64,
          width: 68,
          child: Icon(
            Icons.data_usage_rounded,
            size: 38,
          ),
        ),
        Container(
          height: 64,
          width: 68,
          child: Icon(
            Icons.wifi,
            size: 38,
          ),
        ),
        Container(
          height: 64,
          width: 68,
          child: Icon(
            Icons.network_cell,
            size: 38,
          ),
        ),
      ],
    );
  }
}
