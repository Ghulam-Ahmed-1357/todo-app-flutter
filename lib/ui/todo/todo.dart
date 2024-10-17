// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/ui/todo/edit_todo.dart';
// import 'package:intl/intl.dart';
import 'package:todo_firebase/utils/util.dart';
import 'dart:math' as math;

import '../auth/login.dart';
import 'add_todo.dart';

enum Priority {
  Lowest,
  Normal,
  Highest,
}

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final Stream<QuerySnapshot> todosStream =
      FirebaseFirestore.instance.collection('todos').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todos"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: todosStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var dataList = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      var item =
                          dataList[index].data()! as Map<String, dynamic>;
                      return Container(
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          margin:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, left: 5),
                              child: Icon(
                                Icons.circle,
                                color: Color((math.Random().nextDouble() *
                                            0xFFFFFF)
                                        .toInt())
                                    .withOpacity(1.0),
                              ),
                            ),
                            title: Text(
                              item["task"],
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text(Util.formatDate(item["when"].toDate())),
                            trailing:
                                item["priority"] == Priority.Highest.name
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 25,
                                      )
                                    : SizedBox(),
                          ),
                        ),
                      );
                    });
              }
              return Center(
                child: Text("No todos yet"),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodo()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
