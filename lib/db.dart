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
            "Minato",
            "NAMIKAZE",
            "12-07-1960",
            "Cotonou",
            "67543244",
            "minatonamikaze@gmail.com",
            "Masculin",
            "images/Minato.jpg",
            "Un Hokagé doit protéger son village"
        ),
        User(
            null,
            1,
            "Naruto",
            "UZMAKI",
            "23-12-2003",
            "Cotonou",
            "56235335",
            "uzmakinaruto@gmail.com",
            "Masculin",
            "images/Naruto.jpg",
            "Je deviendrai le Hokage le plus balaise"
        ),
        User(
            null,
            1,
            "Lee",
            "ROCK",
            "03-01-2001",
            "Cotonou",
            "98765432",
            "rocklee@gmail.com",
            "Masculin",
            "images/Lee.jpg",
            "Je serai un shinobi qu'avec le Taijutsu"
        ),
        User(
            null,
            1,
            "Gaara",
            "DU DESERT",
            "06-06-2002",
            "Cotonou",
            "76543288",
            "gaaradudesert@gmail.com",
            "Masculin",
            "images/Gaara.jpg",
            "Le tombo du désert"
        ),
    ];
}