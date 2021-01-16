import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TodoLicensePage extends StatefulWidget {
  @override
  _TodoLicensePageState createState() => _TodoLicensePageState();
}

class _TodoLicensePageState extends State<TodoLicensePage> {
  String licenceText = '';

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('LICENSE').then((value) {
      setState(() {
        licenceText = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.blue,
        backwardsCompatibility: false,
        centerTitle: true,
        title: Text(
          'LICENCIA LPTL 1.0',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(licenceText),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.to(LicensePage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.verified_user,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Otras licencias',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
