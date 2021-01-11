import 'package:todo/features/ussd_codes/domain/entities/ussd_item.dart';
import 'package:meta/meta.dart';

class UssdCategory extends UssdItem {
  final List<UssdItem> items;

  UssdCategory({
    @required String name,
    @required String description,
    @required String icon,
    @required String type,
    @required this.items,
  }) : super(name: name, description: description, icon: icon, type: type);

  List<Object> get props => super.props..addAll([items]);
}
