// // ignore_for_file: prefer_const_constructors, sort_child_properties_last

// import 'package:flutter/material.dart';
// class Edittodo extends StatefulWidget {
//   const Edittodo({super.key});

//   @override
//   State<Edittodo> createState() => _EdittodoState();
// }

// String? newtask;

// class _EdittodoState extends State<Edittodo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Edit Todo task")),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // Container(
//             //   height: 30,
//             //   width: 30,
//             //   child: Text(),
//             // )

//             TextField(
//               onChanged: (value) {
//                 newtask = value;
//               },
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   hintText: "Edit task"),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   var data = {"task": newtask};
//                 },
//                 child: Text("Edit task"),
//                 style: ElevatedButton.styleFrom(
//                     minimumSize: Size.fromHeight(50),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30))))
//           ],
//         ),
//       ),
//     );
//   }
// }
