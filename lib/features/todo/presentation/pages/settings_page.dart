import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/platform_channels/platform_channels.dart';
import 'package:todo/features/todo/presentation/pages/pages.dart';
import 'package:todo/features/todo/presentation/widgets/widgets.dart';

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
              SizedBox(height: 30),
              SettingSwitch(
                text: 'Activar widget flotante',
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
              SettingSwitch(
                text: 'Apagar wifi al desconectar',
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
              SizedBox(height: 30),
              SettingButton(
                text: 'Términos de uso',
                icon: Icons.verified_user,
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(height: 10),
              SettingButton(
                text: 'Licencia LPTL',
                icon: Icons.verified_user,
                onPressed: () {
                  Get.to(TodoLicensePage());
                },
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
            child: Text(
              appVersion,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
