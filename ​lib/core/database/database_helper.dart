import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('noor_alquran.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Check if the database exists
    bool exists = await databaseExists(path);

    if (!exists) {
      // Should happen only if pre-bundled database is missing; create empty schema & seed
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset if bundled, or create schema
      ByteData data = await rootBundle.load('assets/quran/noor_alquran.db');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE surahs (
        number INTEGER PRIMARY KEY,
        arabic_name TEXT NOT NULL,
        transliteration TEXT NOT NULL,
        english_name TEXT NOT NULL,
        ayah_count INTEGER NOT NULL,
        revelation_type TEXT NOT NULL,
        juz_start INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ayahs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah_number INTEGER NOT NULL,
        ayah_number INTEGER NOT NULL,
        arabic_text TEXT NOT NULL,
        juz_number INTEGER NOT NULL,
        page_number INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE translations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        language_code TEXT NOT NULL,
        translator_name TEXT NOT NULL,
        surah_number INTEGER NOT NULL,
        ayah_number INTEGER NOT NULL,
        translated_text TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE bookmarks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah_number INTEGER NOT NULL,
        ayah_number INTEGER NOT NULL,
        note TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reading_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah_number INTEGER NOT NULL,
        ayah_number INTEGER NOT NULL,
        last_opened_at TEXT NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getSurahs() async {
    final db = await instance.database;
    return await db.query('surahs', orderBy: 'number ASC');
  }

  Future<List<Map<String, dynamic>>> getAyahsForSurah(int surahNumber) async {
    final db = await instance.database;
    return await db.query(
      'ayahs',
      where: 'surah_number = ?',
      whereArgs: [surahNumber],
      orderBy: 'ayah_number ASC',
    );
  }

  Future<void> addBookmark(int surahNumber, int ayahNumber, String note) async {
    final db = await instance.database;
    await db.insert('bookmarks', {
      'surah_number': surahNumber,
      'ayah_number': ayahNumber,
      'note': note,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final db = await instance.database;
    return await db.query('bookmarks', orderBy: 'created_at DESC');
  }

  Future<void> removeBookmark(int id) async {
    final db = await instance.database;
    await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }
}
