import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}


// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
// void main() async {
//   // Avoid errors caused by flutter upgrade.
//   // Importing 'package:flutter/widgets.dart' is required.
//   WidgetsFlutterBinding.ensureInitialized();
//   // Open the database and store the reference.
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'database.db'),
//     // When the database is first created, create a table to store Users.
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         'CREATE TABLE Users(id INTEGER PRIMARY KEY, nickname TEXT, password TEXT)',
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );

//   // Define a function that inserts Users into the database
//   Future<void> insertUser(User User) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the User into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same User is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'Users',
//       User.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // A method that retrieves all the Users from the Users table.
//   Future<List<User>> Users() async {
//     // Get a reference to the database.
//     final db = await database;

//     // Query the table for all The Users.
//     final List<Map<String, dynamic>> maps = await db.query('Users');

//     // Convert the List<Map<String, dynamic> into a List<User>.
//     return List.generate(maps.length, (i) {
//       return User(
//         id: maps[i]['id'],
//         nickname: maps[i]['nickname'],
//         password: maps[i]['password'],
//       );
//     });
//   }

//   Future<void> updateUser(User User) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Update the given User.
//     await db.update(
//       'Users',
//       User.toMap(),
//       // Ensure that the User has a matching id.
//       where: 'id = ?',
//       // Pass the User's id as a whereArg to prevent SQL injection.
//       whereArgs: [User.id],
//     );
//   }

//   Future<void> deleteUser(int id) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Remove the User from the database.
//     await db.delete(
//       'Users',
//       // Use a `where` clause to delete a specific User.
//       where: 'id = ?',
//       // Pass the User's id as a whereArg to prevent SQL injection.
//       whereArgs: [id],
//     );
//   }

//   // Create a User and add it to the Users table
//   var fido = User(
//     id: 0,
//     nickname: 'Fido',
//     password: 'StrongPassword',
//   );

//   await insertUser(fido);

//   // Now, use the method above to retrieve all the Users.
//   print(await Users()); // Prints a list that include Fido.

//   // Update Fido's password and save it to the database.
//   fido = User(
//     id: fido.id,
//     nickname: fido.nickname,
//     password: 'StrongERPassword',
//   );
//   await updateUser(fido);

//   // Print the updated results.
//   print(await Users()); // Prints Fido with age 42.

//   // Delete Fido from the database.
//   await deleteUser(fido.id);

//   // Print the list of Users (empty).
//   print(await Users());
// }

class Task {
  final int id;
  String title;
  Space space;

  Task({
    required this.id,
    required this.title,
    required this.space,
  });

  // Convert a User into a Map. The keys must correspond to the nicknames of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'space': space,
    };
  }

  // Implement toString to make it easier to see information about
  // each User when using the print statement.
  @override
  String toString() {
    return 'Task{id: $id, title: $title, space: $space}';
  }
  
}

class Space {
  final int id;
  String name;
  List<Task>? tasks;

  Space({
    required this.id,
    required this.name,
  });

  // Convert a User into a Map. The keys must correspond to the nicknames of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tasks': tasks,
    };
  }

  // Implement toString to make it easier to see information about
  // each User when using the print statement.
  @override
  String toString() {
    return 'Space{id: $id, name: $name, tasks: $tasks}';
  }
  
}

class User {
  final int id;
  final String nickname;
  final String password;
  List<Space>? spaces;

  User({
    required this.id,
    required this.nickname,
    required this.password,
  });

  // Convert a User into a Map. The keys must correspond to the nicknames of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'password': password,
    };
  }

  // Implement toString to make it easier to see information about
  // each User when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, nickname: $nickname, password: $password}';
  }
}
