import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import '../models/item_model.dart';
import 'repository.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  Database? db;
  NewsDbProvider() {
    init();
  }
  Future<void> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        Batch batch = newDb.batch();
        batch.execute("""
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER,
            text TEXT
          )
        """);
        batch.commit();
      },
    );
  }

  @override
  Future<List<int>> fetchTopIds() async {
    return [];
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    if (db == null) await init();
    final item = await db!.query(
      "Items",
      where: "id = ?",
      whereArgs: [id],
    );
    if (item.length != 1) return null;
    return ItemModel.fromDb(item.first);
  }

  @override
  Future<int> addItem(ItemModel? item) async {
    if (db == null) await init();
    return db!.insert("Items", item!.toDb());
  }

  @override
  Future<int> clear() async {
    if (db == null) await init();
    return db!.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();
