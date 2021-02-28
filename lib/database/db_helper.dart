import 'package:rss_news/models/rss_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;
  static final int _version = 1;
  static final String _tableName = 'rss';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'rss_news.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, nom STRING, lien STRING)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<int> insert(RssModel rssModel) async =>
      await _db.insert(_tableName, rssModel.toJson());

  Future<int> update(RssModel rssModel) async {
    return await _db.update(_tableName, rssModel.toJson(),
        where: 'id = ?', whereArgs: [rssModel.id]);
  }

  Future<int> delete(int id) async =>
      await _db.delete(_tableName, where: 'id = ?', whereArgs: [id]);

  Future<List<RssModel>> get(dynamic id) async {
    var resQuery = await _db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    return resQuery.map((data) => new RssModel.fromJson(data)).toList();
  }

  Future<List<RssModel>> query() async {
    var resQuery = await _db.query(_tableName, orderBy: "nom ASC");
    return resQuery.map((data) => new RssModel.fromJson(data)).toList();
  }

}
