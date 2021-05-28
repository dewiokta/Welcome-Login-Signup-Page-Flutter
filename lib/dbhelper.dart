import 'package:flutter_auth/model/pet.dart';
import 'package:flutter_auth/model/petfood.dart';
import 'package:flutter_auth/model/accessories.dart';
import 'package:flutter_auth/model/history.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'petshop.db';
    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);

    return itemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS pet');
    await db.execute('DROP TABLE IF EXISTS petfood');
    await db.execute('DROP TABLE IF EXISTS accessories');
    await db.execute('DROP TABLE IF EXISTS history');

    await db.execute('''
    CREATE TABLE pet (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      gambar TEXT,
      detail TEXT,
      price INTEGER,
      stok INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE petfood (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      gambar TEXT,
      detail TEXT,
      price INTEGER,
      stok INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE accessories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      gambar TEXT,
      detail TEXT,
      price INTEGER,
      stok INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE history (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      alamat TEXT,
      email TEXT,
      dibeli TEXT,
      price INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE transaksi (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      alamat TEXT,
      email TEXT,
      qty INTEGER,
      total_price INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE booking (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      pet_name TEXT,
      email TEXT,
      jenis_hewan TEXT,
      jenis_grooming TEXT
    )
    ''');

    await db.execute(
        'INSERT INTO pet (nama, gambar, detail, price, stok) VALUES ("Kucing", "https://picture-origin.rumah123.com/news-content/img/2020/12/15100751/Untitled-design-2020-12-15T100743.826.jpg", "Persian Cat", 2000000, 5)');
    await db.execute(
        'INSERT INTO pet (nama, gambar, detail, price, stok) VALUES ("Hamster", "https://ilmubudidaya.com/wp-content/uploads/2017/11/jenis-hamster-campbell.jpg", "Campbell Hamster", 40000, 10)');

    await db.execute(
        'INSERT INTO petfood (nama, gambar, detail, price, stok) VALUES ("Whiskas Tuna", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full/whiskas_whiskas-adult-tuna-makanan-kucing--480-g-_full01.jpg", "cat food | adult (480 g)", 30000, 20)');

    await db.execute(
        'INSERT INTO accessories (nama, gambar, detail, price, stok) VALUES ("Bell Necklace", "https://img.alicdn.com/imgextra/i3/3338141730/TB2A3wnaI2vU1JjSZFwXXX2cpXa_!!3338141730.jpg_460x460q90.jpg", "for cat or dog", 30000, 15)');
  }

  //select
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('pet', orderBy: 'nama');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectFd() async {
    Database db = await this.initDb();
    var mapList = await db.query('petfood', orderBy: 'nama');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectAc() async {
    Database db = await this.initDb();
    var mapList = await db.query('accessories', orderBy: 'nama');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectHs() async {
    Database db = await this.initDb();
    var mapList = await db.query('history', orderBy: 'id');
    return mapList;
  }

  //insert
  Future<int> insert(Pet object) async {
    Database db = await this.initDb();
    int count = await db.insert('pet', object.toMap());
    return count;
  }

  Future<int> insertFd(Petfood object) async {
    Database db = await this.initDb();
    int count = await db.insert('petfood', object.toMap());
    return count;
  }

  Future<int> insertAc(Accessories object) async {
    Database db = await this.initDb();
    int count = await db.insert('accessories', object.toMap());
    return count;
  }

  //update
  Future<int> update(Pet object) async {
    Database db = await this.initDb();
    int count = await db
        .update('pet', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> updateFd(Petfood object) async {
    Database db = await this.initDb();
    int count = await db.update('petfood', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> updateAc(Accessories object) async {
    Database db = await this.initDb();
    int count = await db.update('accessories', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  updatePetBuy(String nama) async {
    final db = await this.initDb();
    var result = await db
        .execute('UPDATE pet SET stok = (stok-1) WHERE nama = "' + nama + '"');
    return result;
  }

  updateFdBuy(String nama) async {
    final db = await this.initDb();
    var result = await db.execute(
        'UPDATE petfood SET stok = (stok-1) WHERE nama = "' + nama + '"');
    return result;
  }

  updateAcBuy(String nama) async {
    final db = await this.initDb();
    var result = await db.execute(
        'UPDATE accessories SET stok = (stok-1) WHERE nama = "' + nama + '"');
    return result;
  }

  //delete
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('pet', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<int> deleteFd(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('petfood', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<int> deleteAc(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('accessories', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<int> deleteHs(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('history', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //get list
  Future<List<Pet>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Pet> itemList = List<Pet>();
    for (int i = 0; i < count; i++) {
      itemList.add(Pet.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  Future<List<Petfood>> getItemListFd() async {
    var itemMapList = await selectFd();
    int count = itemMapList.length;
    List<Petfood> itemList = List<Petfood>();
    for (int i = 0; i < count; i++) {
      itemList.add(Petfood.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  Future<List<Accessories>> getItemListAc() async {
    var itemMapList = await selectAc();
    int count = itemMapList.length;
    List<Accessories> itemList = List<Accessories>();
    for (int i = 0; i < count; i++) {
      itemList.add(Accessories.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  Future<List<History>> getItemListHs() async {
    var itemMapList = await selectHs();
    int count = itemMapList.length;
    List<History> itemList = List<History>();
    for (int i = 0; i < count; i++) {
      itemList.add(History.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
