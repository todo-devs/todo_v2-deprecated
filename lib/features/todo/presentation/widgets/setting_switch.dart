import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingSwitch({
    Key key,
    @required this.text,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Switch(
          activeColor: Colors.blue,
          // activeTrackColor: this.darkMode ? null : Colors.white,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
