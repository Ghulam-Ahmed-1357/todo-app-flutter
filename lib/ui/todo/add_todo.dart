// ignore_for_file: avoid_init_to_null, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/utils/util.dart';
import 'todo.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  bool isHighest = false;
  DateTime? selectedDate = null;
  String? task;

  _addTodo() {
    if (task == null || task!.isEmpty) {
      Util.showError(context, "Please enter task");
    } else if (selectedDate == null) {
      Util.showError(context, "Please provide when");
    } else {
      var data = {
        "task": task,
        "when": selectedDate,
        "priority": isHighest ? Priority.Highest.name : Priority.Lowest.name,
        "isCompleted": false
      };
      CollectionReference todos =
          FirebaseFirestore.instance.collection('todos');
      todos.add(data).then((value) {
        Navigator.pop(context);
      }).catchError((e) {
        Util.showError(context, e.toString());
      });
      // Navigator.pop(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("selectedDate == null ${selectedDate == null}");
    return Scaffold(
      appBar: AppBar(title: Text("Add New Todo")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  task = value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Enter Task"),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 7)));
                if (date != null) {
                  var time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (time != null) {
                    setState(() {
                      selectedDate = DateTime(date.year, date.month, date.day,
                          time.hour, time.minute);
                    });
                  }
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(selectedDate == null
                    ? "When"
                    : Util.formatDate(selectedDate!)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                    value: isHighest,
                    onChanged: (bool? value) {
                      setState(() {
                        isHighest = !isHighest;
                      });
                    }),
                Text("Highest")
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: _addTodo,
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
}
