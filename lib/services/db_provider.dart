import 'package:flutter/services.dart';
import 'package:kode4u/utils/k_security.dart';
import '../states/peak_item.dart';
import '../states/story_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class DBProvider {
  final int ITEM_PER_PAGE = 50;
  final String databaseName = 'khmeros.ttf';
  static Database? _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    if (await File(path).exists()) {
    } else {
      ByteData data = await rootBundle.load(join("assets", databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(
      path,
      version: 1,
    );
  }

  Future<void> encryptStory() async {
    final maps = await (await database)!.rawQuery("SELECT * FROM kotelokbook");
    int count = 0;
    for (var item in maps) {
      StoryItem storyItem = StoryItem.fromJson(item);
      count = count + 1;
      storyItem.story = await KSecurity.encrypt(storyItem.story);
      addItem(storyItem);
    }
  }

  Future<List<PeakItem>> fetchMainItem({String lang = ''}) async {
    if (lang == 'en') {
      lang = " WHERE lang='en'";
    } else {
      lang = '';
    }
    List<PeakItem> list = [];
    final maps = await (await database)!.rawQuery(
        "select  bookno as peak, count(bookno) as count from kotelokbook $lang GROUP by	bookno order by peak");
    for (var item in maps) {
      PeakItem peak = PeakItem.fromJson(item);
      list.add(peak);
    }
    print('fetcfh main finished ${list.length}');
    return list;
  }

  Future<List<StoryItem>> fetchTitles({int? bookno, String? lang}) async {
    if (lang == 'en') {
      lang = "AND lang='en'";
    } else {
      lang = "AND lang='kh'";
    }
    List<StoryItem> list = [];
    final maps = await (await database)!
        .rawQuery("SELECT * FROM kotelokbook WHERE bookno=$bookno $lang");
    for (var item in maps) {
      StoryItem story = StoryItem.fromJson(item);
      list.add(story);
    }
    return list;
  }

  bool isHexadecimal(String text) {
    final RegExp hexRegex = RegExp(r'^[0-9a-fA-F]+$');
    return hexRegex.hasMatch(text);
  }

  Future<StoryItem> fetchItem({String? title}) async {
    List<StoryItem> list = [];
    final maps = await (await database)!
        .rawQuery("SELECT * FROM kotelokbook WHERE title='$title' LIMIT 1");
    for (var item in maps) {
      StoryItem story = StoryItem.fromJson(item);
      story.story = isHexadecimal(story.story)
          ? (await KSecurity.decrypt(story.story))
          : story.story;
      list.add(story);
    }
    return list[0];
  }

  Future<int> addItem(StoryItem item) async {
    int result = await (await database)!.insert("kotelokbook", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }
}
