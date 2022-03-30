import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_managment/user.dart';

class Db {
    Db._();
    static final Db instance = Db._();
    static Database? _database;
    
    Future <Database?> get database async {
        if (_database != null) return _database;
        _database = await initDB();
        return _database;
    }

    initDB() async {
        WidgetsFlutterBinding.ensureInitialized();
        return await openDatabase(
            join(await getDatabasesPath(), 'database.db'),
            onCreate: (db, version) {
                return db.execute("CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,isAsset INTEGER, firstname TEXT, lastname TEXT, birthday TEXT, mail TEXT, adress TEXT, phone TEXT, gender TEXT, picture TEXT, citation TEXT)");
            },
            version: 1,
        );
    }

    void insertUser(User user) async {
        final Database? db = await database;
        await db?.insert(
            'users',
            user.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
        );
    }

    void updateUser(User user) async {
        final Database? db = await database;
        await db?.update(
            'users',
            user.toMap(),
            where: 'id = ?',
            whereArgs: [user.id],
        );
    }

    void deletUser(int id) async {
        final Database? db = await database;
        await db?.delete(
            'users',
            where: 'id = ?',
            whereArgs: [id],
        );
    }

    Future<List<User>> users() async {
        final Database? db = await database;
        final List<Map<String, dynamic>> maps = await db!.query('users');

        List<User> users = List.generate(maps.length, (i) {
            return User.fromMap(maps[i]);
        });

        if (users.isEmpty) {
            for (User user in defaultUsers) {
                insertUser(user);
            }
            users = defaultUsers;
        }
        return users;
    }


    final List<User> defaultUsers = [
        User(
            null,
            1,
            "Arnaud",
            "Lokonon",
            "23-87-2003",
            "arnaudlokonon@gmail.com",
            "Cotonou",
            "56235335",
            "Masculin",
            "images/Minato.jpg",
            "A la guerre comme au village on est tous embarqué"
        ),
        User(
            null,
            1,
            "Ariel",
            "DOSSOU",
            "21-05-2001",
            "arieldossou00@gmail.com",
            "Cotonou",
            "67180009",
            "Masculin",
            "images/Minato.jpg",
            "A la guerre comme au village on est tous embarqué"
        ),
        User(
            null,
            1,
            "Christian",
            "LINGUE",
            "23-87-2002",
            "christianlingue@gmail.com",
            "Cotonou",
            "67180009",
            "Masculin",
            "images/Minato.jpg",
            "A la guerre comme au village on est tous embarqué"
        ),
        User(
            null,
            1,
            "Marc",
            "LENOVO",
            "23-87-2003",
            "marclenovo@gmail.com",
            "Cotonou",
            "67180009",
            "Masculin",
            "images/Minato.jpg",
            "A la guerre comme au village on est tous embarqué"
        ),
        User(
            null,
            1,
            "Etienne",
            "DUJARDIN",
            "23-87-2003",
            "etiennedujardin@gmail.com",
            "Cotonou",
            "67180009",
            "Masculin",
            "images/Minato.jpg",
            "A la guerre comme au village on est tous embarqué"
        ),
        User(
            null,
            1,
            "Steeve",
            "CABREL",
            "23-87-2003",
            "steevcabrel@gmail.com",
            "Cotonou",
            "67180009",
            "Masculin",
            "images/Minato.jpg",
            "A la guerre comme au village on est tous embarqué"
        ),
        User(
            null,
            1,
            "Naruto",
            "UZMAKI",
            "23-87-2003",
            "arnaudlokonon@gmail.com",
            "Cotonou",
            "67180009",
            "Masculin",
            "images/Minato.jpg",
            "A la guerre comme au village on est tous embarqué"
        ),
        User(
            null,
            1,
            "Minato",
            "NAMIKAZE",
            "23-87-2003",
            "arnaudlokonon@gmail.com",
            "Cotonou",
            "67180009",
            "Masculin",
            "images/Minato.jpg",
            "A la guerre comme au village on est tous embarqué"
        )
    ];
}