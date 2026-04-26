import 'package:flutter/material.dart';
import 'package:project/core/db_sqflite.dart';
import 'package:project/core/sharedpreferences_helper.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String username = "";
  TextEditingController notec = TextEditingController();
  TextEditingController titlec = TextEditingController();
  List<Map<String, dynamic>> mynotes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadusername();
    getAllnotes();
  }

  addnote() async {
    await SqfliteHelper().insertNotes(titlec.text, notec.text);
  }

  loadusername() {
    String? usernameDB = CashHelper.getUserName();
    setState(() {
      username = usernameDB ?? "guest";
    });
  }

  getAllnotes() async {
    final listOfnotes = await SqfliteHelper().getAllNotes();
    setState(() {
      mynotes = listOfnotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(username)),
      body: mynotes.isEmpty
          ? Text("no notes")
          : ListView.builder(
              itemCount: mynotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(mynotes[index]['title'] ?? ""),
                  subtitle: Text(mynotes[index]['desc'] ?? ""),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add note"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titlec,
                      decoration: InputDecoration(hintText: "enter your title"),
                    ),
                    TextFormField(
                      controller: notec,
                      decoration: InputDecoration(hintText: "enter your note"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await addnote();
                      await getAllnotes();
                      Navigator.pop(context);
                    },
                    child: Text("add note"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      titlec.clear();
                      notec.clear();
                    },
                    child: Text("cancel"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
