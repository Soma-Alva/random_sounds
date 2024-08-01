import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Event {
  int? id;
  final String title;
  final List<Map<String, String>> cronograma;

  Event({this.id, required this.title, required this.cronograma});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'cronograma': cronograma.map((e) => e.toString()).toList().join('|'), // Convertimos la lista a una cadena
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      cronograma: (map['cronograma'] as String).split('|').map((e) {
        final parts = e.substring(1, e.length - 1).split(', ');
        return {
          'Posición': parts[0].split(': ')[1],
          'Acto': parts[1].split(': ')[1],
        };
      }).toList(),
    );
  }}


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'events.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE events(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, cronograma TEXT)',
        );
      },
    );
  }

  Future<int> insertEvent(Event event) async {
    final db = await database;
    return await db.insert('events', event.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Event>> getEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('events', orderBy: 'id DESC'); // Ordenar por ID descendente
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<void> deleteEvent(int id) async {
    final db = await database;
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }
}
