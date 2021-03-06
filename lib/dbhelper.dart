import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static final _databasename = "ibc24.db";
  static final _databaseversion = 1;

  static final table = "employee";

  static final columnID = 'id';
  static final columnecode = 'ecode';
  static final columndepartment = 'department';
  static final columnkey = 'key';
  static final columnversion = 'version';

  static Database _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database> get databse async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async{
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path,_databasename);
    return await openDatabase(path,version: _databaseversion,onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version) async{
    await db.execute(
      '''
        CREATE TABLE $table(
          $columnID INTEGER PRIMARY KEY,
          $columnecode TEXT NOT NULL,
          $columndepartment VARCHAR(11) NOT NULL,
          $columnkey TEXT NOT NULL,
          $columnversion FLOAT(10,2) NOT NULL
        )
      '''
    );
  }


  /////////////////////////////////////////
  Future<int>insert(Map<String,dynamic> row) async{
    Database db = await instance.databse;
    return await db.insert(table, row);
  }

  Future<List>getall() async {
    Database db = await instance.databse;
    return await db.query(table, columns: [columnID,columnecode,columndepartment,columnkey,columnversion]);
  }

  Future<List>get(int id) async {
    Database db = await instance.databse;
    return await db.rawQuery("select * from $table where $columnID = $id");
  }

//  Future<int>deletedata(int id) async{
//    Database db = await instance.databse;
//    var res = await db.delete(table,where: "id = ?",whereArgs: [id]);
//    return res;
//  }

  Future<int>deletedata() async{
    Database db = await instance.databse;
    var res = await db.delete(table);
    return res;
  }
}