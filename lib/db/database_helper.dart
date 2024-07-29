import 'package:sqflite/sqflite.dart';
import 'package:wawancara_ai/data/models/video.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblVideos = "videos";

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = await openDatabase(
      '$path/videos.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblVideos (
           id TEXT PRIMARY KEY,
           title TEXT,
           file_name TEXT,
           duration INTEGER,
           smile_detection INTEGER,
           gaze_detection INTEGER,
           hand_detection INTEGER,
           head_detection INTEGER,
           type TEXT,
           has_detection INTEGER DEFAULT 0
         )     
      ''');
      },
      version: 2,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertVideo(Video video) async {
    final db = await database;
    if (db != null) {
      await db.insert(_tblVideos, {
        'id': video.id,
        'title': video.title,
        'file_name': video.fileName,
        'duration': video.duration,
        'smile_detection': video.smileDetection,
        'gaze_detection': video.gazeDetection,
        'hand_detection': video.handDetection,
        'head_detection': video.headDetection,
        'type': video.type,
        'has_detection': 0
      });
    }
  }

  Future<Video?> getVideoById(String id) async {
    final Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tblVideos,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      Map<String, dynamic> res = Map<String, dynamic>.from(results.first);
      return Video.fromJson(res);
    } else {
      return null;
    }
  }

  Future<List<Video>> getAllVideos() async {
    final Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblVideos);
    return results.map((res) => Video.fromJson(res)).toList();
  }

  Future<void> deleteVideo(String videoId) async {
    final db = await database;
    await db!.delete(_tblVideos, where: 'id = ?', whereArgs: [videoId]);
  }

  Future<void> updateVideoDetectionValues(String id, int smileDetection, int gazeDetection, int handDetection, int headDetection, int hasDetection) async {
    final db = await database;
    if (db != null) {
      await db.update(
        _tblVideos,
        {
          'smile_detection': smileDetection,
          'gaze_detection': gazeDetection,
          'hand_detection': handDetection,
          'head_detection': headDetection,
          'has_detection': hasDetection
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  Future<int> countVideosByType(String type) async {
    final db = await database;
    if (db != null) {
      var result = await db.rawQuery('SELECT COUNT(*) FROM $_tblVideos WHERE type = ?', [type]);
      return Sqflite.firstIntValue(result) ?? 0;
    }
    return 0;
  }

  Future<int> countUmumVideos() async {
    return await countVideosByType('umum');
  }

  Future<int> countCustomVideos() async {
    return await countVideosByType('custom');
  }

  Future<Map<String, int>> sumDetectionValues() async {
    final db = await database;
    if (db != null) {
      final result = await db.rawQuery('SELECT SUM(smile_detection) AS smileDetectionSum, SUM(gaze_detection) AS gazeDetectionSum, SUM(hand_detection) AS handDetectionSum, SUM(head_detection) AS headDetectionSum FROM $_tblVideos');

      return {
        'smileDetectionSum': (result.first['smileDetectionSum'] as int?) ?? 0,
        'gazeDetectionSum': (result.first['gazeDetectionSum'] as int?) ?? 0,
        'handDetectionSum': (result.first['handDetectionSum'] as int?) ?? 0,
        'headDetectionSum': (result.first['headDetectionSum'] as int?) ?? 0,
      };
    }
    return {};
  }
}
