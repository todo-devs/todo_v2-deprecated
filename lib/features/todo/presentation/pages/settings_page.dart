import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/platform_channels/platform_channels.dart';
import 'package:todo/features/todo/presentation/pages/pages.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final appVersion = 'TODO v2.0';
  var showWidget = false;
  var turnOffWifi = false;

  @override
  void initState() {
    super.initState();

    getShowWidgetPreference().then((value) {
      setState(() {
        showWidget = value;
      });
    });

    getTurnOffWifiPreference().then((value) {
      setState(() {
        turnOffWifi = value;
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
          'Ajustes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Activar widget flotante',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Switch(
                    activeColor: Colors.blue,
                    // activeTrackColor: this.darkMode ? null : Colors.white,
                    value: showWidget,
                    onChanged: (value) {
                      if (value) {
                        setTrueShowWidget();
                      } else {
                        setFalseShowWidget();
                      }

                      getShowWidgetPreference().then((value) {
                        setState(() {
                          showWidget = value;
                        });
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Apagar wifi al desconectar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Switch(
                    activeColor: Colors.blue,
                    value: turnOffWifi,
                    onChanged: (value) {
                      if (value) {
                        setTrueTurnOffWifi();
                      } else {
                        setFalseTurnOffWifi();
                      }

                      getTurnOffWifiPreference().then((value) {
                        setState(() {
                          turnOffWifi = value;
                        });
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
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
                        'Términos de uso',
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
              GestureDetector(
                onTap: () {
                  Get.to(TodoLicensePage());
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
                        'Licencia LPTL',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(appVersion),
          )
        ],
      ),
    );
  }
}
