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
        title: const Text('Note SQL'),
      ),
      body:  Column(
        children: [
          Expanded(
              child: FutureBuilder(
              future: notesList,
              builder: (context, AsyncSnapshot<List<NotesModel>> snaphsot) {
               /* if(!snaphsot.hasData){
                  return const Text("data");
                }
                else{*/
                  return ListView.builder(
                      itemCount: snaphsot.data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0.0),
                            title: Text(snaphsot.data![index].title.toString()),
                            subtitle: Text(snaphsot.data![index].title.toString()),
                            trailing: Text(snaphsot.data![index].age.toString()),
                          ),
                        );
                      });
                //}
              }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dbHelper
              ?.insert(NotesModel(
                  title: 'Pawan Kumar Chauhan',
                  age: 24,
                  description: 'This is very bad boy...',
                  email: 'pawan.chauhan7394@gmail.com'))
              .then((value) {
            print('data added');
          }).onError((error, stackTrace) {
            print(error.toString());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
