// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_demo/Home/OCPPServer/Model/OCPPServerModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableOCPPServer = 'OCPPServerModelTable';
  final String id = "id";
  final String name = "name";
  final String domain = "domain";
  final String port = "port";
  final String type = "type";
  final String version = "version";
  final String tls = "tls";
  final String execute = "execute";
  final String certId = "certId";
  final String passphrase = "passphrase";
  final String passSupprot = "passSupprot";
  final String aliasNumber = "aliasNumber";
  final String location = "location";
  final String applyVersion = "applyVersion";
  final String code = "code";
  final String url = "url";
  final String isSelected = "isSelected";

  Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'OCPPServerModelTableData.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableOCPPServer($id TEXT PRIMARY KEY, $name TEXT, $domain TEXT, $port TEXT, $type TEXT, $version TEXT, $tls TEXT, $execute TEXT, $certId TEXT, $passphrase TEXT, $passSupprot TEXT, $aliasNumber TEXT, $location TEXT, $applyVersion TEXT, $code TEXT, $url TEXT, $isSelected TEXT)');
  }

  Future<int> saveOCPPServerModel(OCPPServerModel note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableOCPPServer, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<OCPPServerModel>?> getAllOCPPServerModels({int? offset}) async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps =
        await dbClient.query(tableOCPPServer);
    var result = await dbClient.query(
      tableOCPPServer,
      columns: [
        id,
        name,
        domain,
        port,
        type,
        version,
        tls,
        execute,
        certId,
        passphrase,
        passSupprot,
        aliasNumber,
        location,
        applyVersion,
        code,
        url,
        isSelected
      ],
      limit: maps.length,
      offset: offset,
    );
    // return result.toList();
    if (result.isNotEmpty) {
      return List.generate(result.length, (i) {
        return OCPPServerModel.fromMap(result[i]);
      });
    }
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableOCPPServer'));
  }

  Future<List<OCPPServerModel>?> getOCPPServerModel(int ID) async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(tableOCPPServer,
        columns: [
          id,
          name,
          domain,
          port,
          type,
          version,
          tls,
          execute,
          certId,
          passphrase,
          passSupprot,
          aliasNumber,
          location,
          applyVersion,
          code,
          url,
          isSelected
        ],
        where: '$id = ?',
        whereArgs: [ID]);

    if (result.isNotEmpty) {
      return List.generate(result.length, (i) {
        return OCPPServerModel.fromMap(result[i]);
      });
    }
  }

  Future<List<OCPPServerModel>> queryOCPPServerModel() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps =
        await dbClient.query(tableOCPPServer);
    return List.generate(maps.length, (i) {
      return OCPPServerModel.fromMap(maps[i]);
    });
  }

  Future<int> deleteOCPPServerModel(OCPPServerModel ocppServerModel) async {
    var dbClient = await db;
    return await dbClient.delete(tableOCPPServer,
        where: '$id = ?', whereArgs: [ocppServerModel.id]);
  }

  Future<int> updateOCPPServerModel(OCPPServerModel ocppServerModel) async {
    var dbClient = await db;
    return await dbClient.update(tableOCPPServer, ocppServerModel.toMap(),
        where: "$id = ?", whereArgs: [ocppServerModel.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
