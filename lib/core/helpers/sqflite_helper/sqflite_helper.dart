import 'dart:developer';

import 'package:masrofatak/core/helpers/sqflite_helper/sqflite_keys.dart';
import 'package:sqflite/sqflite.dart';

abstract class SqfliteHelper {
  static late Database _db;

  static Future<void> createUserTable() async {
    await _db.execute("""CREATE TABLE ${SqfliteKeys.userTable}(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT ,
          email TEXT ,
          photo TEXT ,
          token TEXT
        )""");
  }

  static Future<void> init() async {
    _db = await openDatabase(
      'masrofatak.db',
      version: 1,
      onCreate: (db, version) async {
        _db = db;
        await createUserTable();
        log('created successfully');
      },
      onOpen: (db) async {
        log('open successfully');
      },
    );
  }

  static Future<void> insert({
    required Map<String, Object?> data,
    required String tableName,
  }) async {
    await _db.insert(tableName, data).then((_) {
      log('inserted successfully');
    });
  }

  static Future<void> deleteRow(String id) async {
    await _db.transaction((txn) async {
      await txn.rawDelete('DELETE FROM masrofatak WHERE id = $id').then((_) {
        log('deleted successfully');
      });
    });
  }

  static Future<void> delete(
      {required String tableName, required String id}) async {
    await _db.delete(tableName, where: 'id = ?', whereArgs: [id]).then((_) {
      log('deleted successfully sdfsdf');
    });
  }

  static Future<List<Map<String, Object?>>> getAll(
      {required String tableName}) async {
    return await _db.query(tableName, orderBy: "id");
  }

  static Future<Map<String, Object?>?> get(
      {required String tableName, required String id}) async {
    await _db.query(tableName, where: 'id = ?', whereArgs: [id]).then((value) {
      return value;
    });
    return null;
  }

  static Future<void> updateRow(
      {required Map<String, Object?> data,
      required String tableName,
      required String id}) async {
    await _db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
  }
}
