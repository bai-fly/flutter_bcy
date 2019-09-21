  
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB{
  static const String _dbName='my_db.db';

  static Future<Database> getDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
        // 获取数据库文件的存储路径
        Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE imageList (id INTEGER PRIMARY KEY, baseUrl TEXT, image TEXT)');
        });
    return database;
  }
  static DeleteDb() async {
    var databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, _dbName);
    if (await Directory(dirname(path)).exists()) {
      await deleteDatabase(path);
    }
  }
    
}