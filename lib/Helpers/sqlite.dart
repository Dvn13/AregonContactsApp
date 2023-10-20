import 'dart:async';
import 'package:contacts_app/Pages/login/model/login_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqLiteHelper {
  static final SqLiteHelper instance = SqLiteHelper._privateConstructor();
  static Database? _database;

  SqLiteHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT
      )
    ''');
  }

  Future<bool> insertUser(String email, String password) async {
    final db = await database;

   
    final existingUser =
        await db.query('users', where: 'email = ?', whereArgs: [email]);
    if (existingUser.isNotEmpty) {
    
      return false;
    }

    final values = {
      'email': email,
      'password': password,
    };

    try {
      await db.insert('users', values);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<LoginUserModel?> getUser(String email) async {
    final db = await SqLiteHelper.instance.database;
    final userList =
        await db.query('users', where: 'email = ?', whereArgs: [email]);

    if (userList.isNotEmpty) {
      final userMap = userList.first;
      final email = userMap['email'] as String;
      final password = userMap['password'] as String;
      return LoginUserModel.fromJson({'email': email, 'sifre': password});
    }

    return null;
  }
}
