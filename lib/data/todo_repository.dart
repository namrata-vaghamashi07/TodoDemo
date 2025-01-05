import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:todo_demo/data/todo_model.dart';

class TodoRepository {
  static final TodoRepository instance = TodoRepository._init();
  static Database? _database;

  TodoRepository._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final pathWithName = p.join(dbPath, path);
    return openDatabase(pathWithName, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        status TEXT,
        timer INTEGER
      )
    ''');
  }

  //Add todo item
  Future<int> addTodo(Todo todo) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get todo list
  Future<List<Todo>> getTodos() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  // Update todo item
  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;
    return await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  // delet todo item
  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  // Search todos by title
  Future<List<Todo>> searchTodos(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'todos',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((json) => Todo.fromMap(json)).toList();
  }
}
