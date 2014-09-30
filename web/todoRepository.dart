part of Todo;

class Todo {
  String text;
  bool isComplete;
  String dbKey;

  Todo(this.text, this.isComplete);

  Map asRaw() {
    return {
      'text': text,
      'isComplete': false
    };
  }
}

class TodoRepository {
  static const String TODO_STORE = 'todoStore';
  static const String NAME_INDEX = 'name_index';
  Database _db;

  Future open() {
    return window.indexedDB.open('todoDB', 
        version: 1, 
        onUpgradeNeeded: _initializeDatabase)
      .then(_loadDb);
  }

  void _initializeDatabase(VersionChangeEvent event) {
    Database db = (event.target as Request).result;

    var objectStore = db.createObjectStore(TODO_STORE, autoIncrement: true);
    var index = objectStore.createIndex(NAME_INDEX, 'todoNAME', unique: true);
  }

  Future _loadDb(Database db){
    _db = db;
  }

  Future<Todo> add(Todo todo) {
    var transaction = _db.transaction(TODO_STORE, 'readwrite');
    var objectStore = transaction.objectStore(TODO_STORE);
    
    objectStore.add(todo.asRaw()).then((addedKey) {
      todo.dbKey = addedKey;
    });

    return transaction.completed.then(() {
      return todo;
    });
  }
}
