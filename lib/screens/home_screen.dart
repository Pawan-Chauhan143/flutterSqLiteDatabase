import 'package:flutter/material.dart';
import 'package:sqlitedatabase/database/database_handler.dart';
import 'package:sqlitedatabase/model/notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNoteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Note SQL',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: notesList,
                  builder: (context, AsyncSnapshot<List<NotesModel>> snaphsot) {
                    if (!snaphsot.hasData) {
                      return const Text("data");
                    } else {
                      return ListView.builder(
                          itemCount: snaphsot.data?.length,
                          itemBuilder: (context, index) {
                            return Card.outlined(
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.home),
                                ),
                                title: Text(
                                  snaphsot.data![index].title.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                subtitle: Text(snaphsot.data![index].description
                                    .toString()),
                                trailing:
                                    Text(snaphsot.data![index].age.toString()),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NotesModel notesModel = NotesModel();
          notesModel.title = 'Lorem Ipsum';
          notesModel.description =
              'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.';
          notesModel.age = 22;
          notesModel.email = 'pawan.chauhan7394@gmail.com';
          dbHelper?.insert(notesModel).then((value) {
            print('data added');
            setState(() {
              loadData();
            });
          }).onError((error, stackTrace) {
            print(error.toString());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
