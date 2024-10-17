import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/ui/auth/login.dart';

import '../todo/todo.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  checkLogin() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Todo()), (route) => false);
      // Todo
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
      //
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) => checkLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlutterLogo(
        size: 200,
      )),
    );
  }
}
