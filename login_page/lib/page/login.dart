import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:login_page/page/signup.dart';
import 'package:login_page/page/user/home.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

import 'forgot.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var user;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Future Sentmail() async {
  //   final service_id = 'service_2o5a1lm';
  //   final template_id = 'template_ia49dcy';
  //   final user_id = 'Lq8qpFI6c-OtEmOBx';

  //   var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  //   try {
  //     final uid = FirebaseAuth.instance.currentUser!.uid;
  //     print(uid);
  //     var res = await http.post(url,
  //         headers: {
  //           'origin': 'http://localhost',
  //           'Content-type': 'application/json'
  //         },
  //         body: json.encode({
  //           'service_id': service_id,
  //           'template_id': template_id,
  //           'user_id': user_id,
  //           'template_params': {
  //             'user': email,
  //           }
  //         }));
  //   } catch (e) {
  //     print('error ${e}');
  //   }
  // }

  // var varuser = FirebaseAuth.instance.currentUser!.uid;

  userLogin() async {
    try {
      // print(uid);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Logged in succusfully!!',
            style: TextStyle(fontSize: 18, color: Colors.black),
          )));
      // Sentmail();
      final uid = FirebaseAuth.instance.currentUser!.uid;
      print('${uid} my uid');
      // curUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homemain()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found!');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'User Not found! please register',
              style: TextStyle(fontSize: 18, color: Colors.black),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Wrong password please enter right password',
              style: TextStyle(fontSize: 18, color: Colors.black),
            )));
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Form(
          key: formkey,
          child: ListView(children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 0),
                        child: TextFormField(
                            autofocus: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                            ),
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('Enter password');
                              }
                              return null;
                            }
                            // validator: (value) =>
                            //     value!.isEmpty ? 'Email cannot be balcned' : null,
                            )),
                    // Container(
                    //     margin: const EdgeInsets.only(right: 180),
                    //     child: TextButton(
                    //       onPressed: () => {
                    //         Navigator.pushAndRemoveUntil(
                    //             context,
                    //             PageRouteBuilder(
                    //                 pageBuilder: ((context, a, b) =>
                    //                     ForgotPassword()),
                    //                 transitionDuration: Duration(seconds: 3)),
                    //             (route) => false)
                    //       },
                    //       child: const Text(
                    //         'Forgot password?',
                    //         style: TextStyle(
                    //             color: Colors.deepPurpleAccent, fontSize: 18),
                    //       ),
                    //     )),
                    Container(
                        margin: const EdgeInsets.all(18),
                        child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                  password = passwordController.text;
                                  print(email + password);
                                });
                                userLogin();
                              }
                            },
                            child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Log In',
                                  style: TextStyle(fontSize: 20),
                                )))),
                    Row(children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 13),
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 19),
                          )),
                      // const Padding(padding: EdgeInsets.only(left: 120)),
                      TextButton(
                          onPressed: () => {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, a, b) =>
                                            Signup(),
                                        transitionDuration:
                                            Duration(seconds: 5)),
                                    (route) => false)
                              },
                          child: const Text(
                            'create one',
                            style: TextStyle(fontSize: 19),
                          ))
                    ]),
                  ],
                ))
          ]),
        ));
  }
}
