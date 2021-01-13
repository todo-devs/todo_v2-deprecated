import 'package:flutter/material.dart';
import 'package:todo/core/platform_channels/platform_channels.dart';
import 'package:todo/core/utils/icons.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart' as GetNV;
import 'package:todo/features/ussd_codes/presentation/pages/pages.dart';

class UssdItemWidget extends StatelessWidget {
  final UssdItem ussdItem;

  const UssdItemWidget({
    Key key,
    @required this.ussdItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: (ussdItem.description.length > 34),
      title: Text(
        ussdItem.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(ussdItem.description),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue,
        ),
        height: 64,
        width: 57,
        child: Icon(
          strIcons[ussdItem.icon],
          size: 32,
          color: Colors.white,
        ),
      ),
      trailing: ussdItem.type == 'category'
          ? Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 16,
            )
          : null,
      onTap: _onTapAction(context),
    );
  }

  Function _onTapAction(BuildContext context) {
    if (ussdItem.type == "code") {
      final item = ussdItem as UssdCode;
      if (item.fields.length == 0) {
        return () {
          callTo(item.code);
        };
      } else {
        return () {
          Get.to(
            UssdCodeFormPage(
              code: ussdItem,
            ),
          );
        };
      }
    } else if (ussdItem.type == "category") {
      return () {
        Get.to(
          UssdCategoryPage(ussdItem),
          preventDuplicates: false,
        );
      };
    }

    throw Exception("Unknown UssdItem type ${ussdItem.type}");
  }
}
