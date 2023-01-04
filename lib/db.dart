// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crud_sqlite/animal.dart';

class DB {
  static final DB _myDatabase = DB._privateConstructor();

  // private constructor
  DB._privateConstructor();

  // databse
  static late Database _database;
  //
  factory DB() {
    return _myDatabase;
  }
  // variables
  final String tableName = 'animal';
  final String columnId = "id";
  final String columnName = 'name'; // usar como id
  final String columnSpec = 'especie';

  //
  // init database
  initializeDatabase() async {
    // Get path where to store database
    Directory directory = await getApplicationDocumentsDirectory();
    // path
    String path = '${directory.path}animales.db';
    // create Database
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        //
        await db.execute(
            'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnSpec TEXT)');
        //
      },
    );
  }

  // CRUD
  // Read
  Future<List<Map<String, Object?>>> getEmpList() async {
    //
    // List<Map<String, Object?>> result = await _database.rawQuery('SELECT * FROM $tableName');
    List<Map<String, Object?>> result =
        await _database.query(tableName, orderBy: columnName);
    return result;
    //
  }

  // Insert
  Future<int> insert_Animal(Animal animal) async {
    //
    int rowsInserted = await _database.insert(tableName, animal.toMap());
    return rowsInserted;
    //
  }

  // Update
  Future<int> update_Animal(Animal animal) async {
    //
    int rowsUpdated = await _database.update(tableName, animal.toMap(),
        where: '$columnId= ?', whereArgs: [animal.id]);
    return rowsUpdated;
    //
  }

  // Delete
  Future<int> delete_Animal(Animal animal) async {
    //
    int rowsDeleted = await _database
        .delete(tableName, where: '$columnId= ?', whereArgs: [animal.id]);
    return rowsDeleted;
    //
  }

  // Count
  Future<int> count_Animal() async {
    //
    List<Map<String, Object?>> result =
        await _database.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
    //
  }
  //

}
