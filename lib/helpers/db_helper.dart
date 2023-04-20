import 'dart:ffi';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class DbHelper {
  static const _placesTableName = "places";
  static const _dbName = "greatPlaces.db";

  static Future<sql.Database> _getDatabasePointer() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, _dbName),
      version: 1,
      onCreate: (dbRefernce, version) async {
        print("table create called");
        await dbRefernce.execute('''
          CREATE TABLE IF NOT EXISTS $_placesTableName ( 
            id TEXT PRIMARY KEY,
            title TEXT,
            image TEXT
          );
        ''');
        print("table created");
      },
    );
  }

  static Future<int> insert(Map<String, Object> data) async {
    final dbPointer = await _getDatabasePointer();
    final statusCode = await dbPointer.insert(
      _placesTableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return statusCode;
  }

  static Future<List<Map<String, Object?>>> getPlaces() async {
    final dbPointer = await _getDatabasePointer();

    return dbPointer.rawQuery("SELECT * FROM $_placesTableName");
  }
}
