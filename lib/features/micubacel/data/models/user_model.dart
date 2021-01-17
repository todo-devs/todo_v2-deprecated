import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/features/micubacel/data/datasources/database.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int id;
  String name;
  String phone;
  String password;

  @JsonKey(fromJson: _activeFromJson, toJson: _activeToJson)
  bool active;

  static bool _activeFromJson(int value) => value == 1;
  static int _activeToJson(bool value) => value ? 1 : 0;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.password,
    this.active = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static List<UserModel> _getUserList(List<Map<String, dynamic>> maps) {
    return maps.map((e) => UserModel.fromJson(e)).toList();
  }

  static Future<UserModel> findById(int id) async {
    final db = await getDataBase();

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );

    final ll = UserModel._getUserList(maps);

    return ll.length != 0 ? ll.first : null;
  }

  static Future<UserModel> findByPhone(String phone) async {
    final db = await getDataBase();

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: "phone = ?",
      whereArgs: [phone],
    );

    final ll = UserModel._getUserList(maps);

    return ll.length != 0 ? ll.first : null;
  }

  static Future<UserModel> get activeUser async {
    final Database db = await getDataBase();

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: "active = ?",
      whereArgs: [1],
    );

    final ll = UserModel._getUserList(maps);

    return ll.length != 0 ? ll.first : null;
  }

  static Future<List<UserModel>> get all async {
    final Database db = await getDataBase();

    final List<Map<String, dynamic>> maps = await db.query('users');

    return UserModel._getUserList(maps);
  }

  Future<void> get save async {
    final db = await getDataBase();

    final result = await UserModel.findByPhone(this.phone);

    if (result != null) {
      result.name = this.name;
      result.password = this.password;
      result.active = this.active;
      await result.update;
    } else {
      final act = await activeUser;

      if (act != null) {
        act.active = false;
        await act.update;
      }

      await db.insert(
        'users',
        {'name': this.name, 'phone': this.phone, 'password': this.password},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> get update async {
    final db = await getDataBase();

    if(this.active) {
      final act = await activeUser;

      if (act != null && act.id != this.id) {
        act.active = false;
        await act.update;
      }
    }

    await db.update(
      'users',
      this.toJson(),
      where: "id = ?",
      whereArgs: [this.id],
    );
  }

  Future<void> get delete async {
    final db = await getDataBase();

    await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
