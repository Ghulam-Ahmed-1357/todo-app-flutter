// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/ui/todo/todo.dart';
import 'package:todo_firebase/utils/util.dart';

import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void _onLogin() async {
    var email = userNameController.text;
    var password = passwordController.text;
    try {
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: ((context) => Todo())), (_) => false);
      }
    } on FirebaseAuthException catch (e) {
      Util.showError(context, e.message);
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorPrimary = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "Welcome to "),
                      TextSpan(
                          text: "Todo App",
                          style: TextStyle(color: colorPrimary))
                    ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter user name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "Enter Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
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
                        onPressed: () {
                          bool isValid = formKey.currentState!.validate();
                          if (isValid) {
                            _onLogin();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size.fromHeight(50)),
                        icon: Icon(Icons.login),
                        label: Text("Login")),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Text("Don't have an account? Signup"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Signup())));
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
