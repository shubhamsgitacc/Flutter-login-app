import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/page/user/dashboard.dart';
import 'package:login_page/page/user/home.dart';
import 'login.dart';
import 'package:email_auth/email_auth.dart';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formkey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmpswrd = "";
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }

  Future Sentmail() async {
    final service_id = 'service_2o5a1lm';
    final template_id = 'template_ia49dcy';
    final user_id = 'Lq8qpFI6c-OtEmOBx';

    var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
      var res = await http.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-type': 'application/json'
          },
          body: json.encode({
            'service_id': service_id,
            'template_id': template_id,
            'user_id': user_id,
            'template_params': {
              'user': email,
            }
          }));
    } catch (e) {
      print('error ${e}');
    }
  }

  regestier() async {
    if (password == confirmpswrd) {
      try {
        // await FirebaseAuth.instance.sendSignInLinkToEmail(email: email, actionCodeSettings:);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Regester Successfull please logged in!!',
              style: TextStyle(fontSize: 18, color: Colors.black),
            )));
        Sentmail();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => Login())));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("The provided password is too weak");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Password should contain minimum 6 character!',
                style: TextStyle(fontSize: 18, color: Colors.black),
              )));
        } else if (e.code == 'email-already-in-use ') {
          print('Account already used');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Account already exist!',
                style: TextStyle(fontSize: 18, color: Colors.black),
              )));
        }
        print('${e} an error');
      }
    } else {
      print('both password must be same!');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Password must be same!',
            style: TextStyle(fontSize: 18, color: Colors.black),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Sign Up',
        )),
        body: ListView(children: [
          Form(
              key: formkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15)),
                    controller: emailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ('Plese enter email');
                      } else if (!value.contains('@')) {
                        return ('Please enter valid email');
                      }
                      return null;
                    },
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 20),
                      child: TextFormField(
                        autofocus: false,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15)),
                        controller: passwordcontroller,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Password';
                          }
                        }),
                      )),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15)),
                    controller: confirmpasswordcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter the password';
                      }
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              email = emailcontroller.text;
                              password = passwordcontroller.text;
                              confirmpswrd = confirmpasswordcontroller.text;
                              print(confirmpswrd);
                            });
                            regestier();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 40)),
                      const Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 17),
                      ),
                      // const Padding(padding: EdgeInsets.only(right: 100)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, a, b) => Login(),
                                    transitionDuration:
                                        const Duration(seconds: 3)),
                                (route) => false);
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(fontSize: 18),
                          ))
                    ],
                  )
                ]),
              ))
        ]));
  }
}
