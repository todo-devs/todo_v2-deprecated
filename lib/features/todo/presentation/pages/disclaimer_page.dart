import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TodoDisclaimerPage extends StatefulWidget {
  @override
  _TodoDisclaimerPageState createState() => _TodoDisclaimerPageState();
}

class _TodoDisclaimerPageState extends State<TodoDisclaimerPage> {
  String licenceText = '';

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('DISCLAIMER').then((value) {
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
          'Términos de uso',
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
            Container(
              margin: EdgeInsets.all(20),
              child: Text(licenceText),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
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
                      'Aceptar',
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
