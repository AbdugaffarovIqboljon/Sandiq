import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TokenManager {
  static late String token;

  static Future<Database> initTokenDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'token_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS token(id INTEGER PRIMARY KEY, token TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> saveToken(String newToken) async {
    final Database database = await initTokenDatabase();
    token = newToken;
    await database.insert(
      'token',
      {'token': newToken},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getToken() async {
    final Database database = await initTokenDatabase();
    final List<Map<String, dynamic>> tokens = await database.query('token');
    if (tokens.isNotEmpty) {
      return tokens.first['token'] as String?;
    }
    return null;
  }
}
