import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/features/micubacel/presentation/pages/pages.dart';

class TodoAccountsPage extends StatelessWidget {
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
          'Administrar Cuentas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.account_circle,
            size: 82,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.blue,
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text('Cuentas Nauta'),
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              height: 64,
              width: 57,
              child: Icon(
                Icons.wifi,
                color: Colors.white,
                size: 32,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 16,
            ),
            onTap: () {},
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text('Cuentas MiCubacel'),
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              height: 64,
              width: 57,
              child: Icon(
                Icons.network_cell,
                color: Colors.white,
                size: 32,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 16,
            ),
            onTap: () {
              Get.to(CubacelAccountsPage());
            },
          ),
        ],
      ),
    );
  }
}
