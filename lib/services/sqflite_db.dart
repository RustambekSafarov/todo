import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String _token = '';
Future<Database> _createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my_database.db');
  Database database = await openDatabase(
    dbPath,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS tokens (id INTEGER PRIMARY KEY, token TEXT)');
    },
  );
  return database;
}

Future<void> saveTokenToDatabase(String token) async {
  Database database = await _createDatabase();
  await database.insert('tokens', {'token': token});
}

Future<String> getTokenFromDatabase() async {
  Database database = await _createDatabase();
  List<Map<String, dynamic>> result = await database.query('tokens', limit: 1);
  print(result);
  if (result.isNotEmpty) {
    return result[0]['token'];
  } else {
    return '';
  }
}
