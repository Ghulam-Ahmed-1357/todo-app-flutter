// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_firebase/ui/todo/todo.dart';
import 'package:todo_firebase/utils/util.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  File? imageSource;

  void userSignup() async {
    var email = userNameController.text;
    var password = passwordController.text;
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Util.showSuccess(context, "User Created Successfully!");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: ((context) => Todo())), (_) => false);
      print("User Created Successfully");
      //
    } on FirebaseAuthException catch (e) {
      Util.showError(context, e.message);
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  void _handleEditImage() async {
    // var _imageSource = await Utils().pickImage();
    // setState(() {
    //   imageSource = _imageSource;
    // });
  }

  @override
  Widget build(BuildContext context) {
    var colorPrimary = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 20),
                    //     child: CircleAvatar(
                    //       backgroundImage: AssetImage("assets/images/logo.png"),
                    //       radius: 100,
                    //       backgroundColor: Colors.blue,
                    //     )

                    //     ),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "Welcome to "),
                      TextSpan(
                          text: "Todo App",
                          style: TextStyle(color: colorPrimary))
                    ])),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(clipBehavior: Clip.none, children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 50,
                        backgroundImage: imageSource != null
                            ? FileImage(imageSource!)
                            : null,
                      ),
                      Positioned(
                        bottom: -5,
                        right: -20,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: CircleBorder(),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: _handleEditImage,
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.supervisor_account),
                          labelText: "Enter Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: userNameController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Enter email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter passsword";
                        } else if (value.length < 6) {
                          return "Password must be atleast 6 chatacters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Enter Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        onPressed: userSignup,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size.fromHeight(50)),
                        icon: Icon(Icons.check),
                        label: Text("Signup")),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Text("Already have an account? Signin"),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Login())));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
