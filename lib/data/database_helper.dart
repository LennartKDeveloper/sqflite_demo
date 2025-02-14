import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  // Singleton-Muster
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDatabaseFromAssets();
    return _database!;
  }

  Future<Database> _openDatabaseFromAssets() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDir.path, "goe_codes.db");

    bool dbExists = await databaseExists(dbPath);

    if (!dbExists) {
      ByteData data = await rootBundle.load("assets/goe_codes.db");
      List<int> bytes = data.buffer.asUint8List();
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(dbPath);
  }

  Future<Map<String, dynamic>> getAllFromGoae(String goae) async {
    final db = await database;
    try {
      var query =
          await db.rawQuery("SELECT * FROM goe_codes WHERE goae_code= '$goae'");
      print(query);
      return query[0];
    } catch (e) {
      return {"description": ""};
    }
  }
}
