import 'dart:developer';

import 'package:sqflite/sqflite.dart';

abstract class SqfliteHelper {
  static late Database _db;

  static Future<void> createTable() async {
    await _db.execute("""CREATE TABLE masrofatak(
         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
         masrofatakName TEXT ,
         masrofatakNumber TEXT
        )""");
  }

  static Future<void> init() async {
    _db = await openDatabase(
      'masrofatak.db',
      version: 1,
      onCreate: (db, version) async {
        _db = db;
        await createTable();
      },
      onOpen: (db) async {},
    );
  }

  static Future<void> insertRow(
      {required String masrofatakName, required String masrofatakNumber}) async {
    await _db.transaction((txn) async {
      await txn.insert(
          'masrofatak', {'masrofatakName': masrofatakName, 'masrofatakNumber': masrofatakNumber}).then((_) {
        log('inserted successfully');
      });
    });
  }

  static Future<void> insert(
      {required String masrofatakName, required String masrofatakNumber}) async {
    await _db.insert(
        'masrofatak', {'masrofatakName': masrofatakName, 'masrofatakNumber': masrofatakNumber}).then((_) {
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

  static Future<void> delete(String id) async {
    await _db.delete('masrofatak', where: 'id = ?', whereArgs: [id]).then((_) {
      log('deleted successfully sdfsdf');
    });
  }

  static Future<List<Map<String, Object?>>> getAll() async {
    return await _db.query('masrofatak', orderBy: "id");
  }

  static Future<void> updateRow(
      {required String masrofatakName,
      required String masrofatakNumber,
      required String id}) async {
    await _db.update('masrofatak', {'masrofatakName': masrofatakName},
        where: 'id = ?', whereArgs: [id]);
  }
}
