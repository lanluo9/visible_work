import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: MyCustomForm(storage: UserStorage()),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key, required this.storage});
  final ProcessEm memberships;
  final UserStorage storage;

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final ProcessEm = 
  
  String? _topuser = 'Nemo';

  @override
  void initState() {
  }

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
      title: Text('App'),
      ),
      body: ListView(
        children: <Widget>[
          keyList.forEach((chore) {
            String? txt = memberships[chore].title;
            if (txt == null) {
              txt = 'Fail';
            }
            ListTile(
              leading: Icon(Icons.map),
              title: Text(txt),
            );
          })]));
  }
      
//       floatingActionButton: FloatingActionButton(
//         // When the user presses the button, show an alert dialog containing
//         // the text that the user has entered into the text field.
//         onPressed: () async {
//           final String contents = await widget.storage.readUser();
//           setState(() {
//             var cntnts = json.decode(contents);
//             List<String> keyList = cntnts.keys.toList();
//             keyList.forEach((key) => memberships.add(new Task.fromJson(cntnts[key])));
//             });
//           if (_topuser == null) {
//             txt = 'Big oof once again';
//           } else {
//             txt = memberships[0].title;
//           }
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 // Retrieve the text the that user has entered by using the
//                 // TextEditingController.
//                 content: Text(txt),
//               );
//             },
//           );
//         },
//         tooltip: 'Show me the value!',
//         child: const Icon(Icons.text_fields),
//       ),
//     );
//   }
}

class UserStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.json');
  }

  Future<String> readUser() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      var fido = Task(id: 0, title: 'Fido', space: 'Kitchen',);
      var outstr = json.encode(fido);
      this.writeUser('{"0":$outstr}');
      // If encountering an error, return 0
      return 'File does not exist?';
    }
  }

  Future<File> writeUser(String counter) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$counter');
  }
}

class ProcessEm {
  Future<String> processStorage(UserStorage storage) async {
    List<Task> memberships = [];
    var keyList;
    final String contents = await storage.readUser();
    var cntnts = json.decode(contents);
    keyList = cntnts.keys.toList();
    keyList.forEach((key) => memberships.add(new Task.fromJson(cntnts[key])));
    return memberships;
  }
}

class Task {
  int? id;
  String? title;
  String? space;

  Task({
    this.id,
    this.title,
    this.space,
  });

  Task.fromJson(Map<String?, dynamic> m) {
    this.id = int.parse(m['id']);
    this.title = m['title'];
    this.space = m['space'];
  }


  // Convert a User into a Map. The keys must correspond to the nicknames of the
  // columns in the database.
  Map<String, dynamic> toJson() => {
      'id': '$id',
      'title': title,
      'space': space,
    };

  // Implement toString to make it easier to see information about
  // each User when using the print statement.
  @override
  String toString() {
    return 'Space{id: $id, name: $title, tasks: $space}';
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
