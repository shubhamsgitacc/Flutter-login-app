import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/page/signup.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formkey = GlobalKey<FormState>();
  var email = '';
  final emailcontroller = TextEditingController();
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  ResetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'The email has been sent! please check your mailbox',
            style: TextStyle(fontSize: 18, color: Colors.black),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-foune') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'User Not found! please register',
              style: TextStyle(fontSize: 18, color: Colors.black),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Forgot Password')),
        body: Form(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              const Text(
                'Reset link will be sent to your email!',
                style: TextStyle(fontSize: 20),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                    labelText: 'Enter Email',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    errorStyle:
                        TextStyle(fontSize: 15, color: Colors.redAccent)),
                controller: emailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!value.contains('@')) {
                    return 'Plese enter valid email';
                  }
                  return null;
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 80, top: 30),
                  child: Row(children: [
                    ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              email = emailcontroller.text;
                            });
                            ResetPassword();
                          }
                        },
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Send email',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ))),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
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
                          'Log in',
                          style: TextStyle(fontSize: 18),
                        ))
                  ])),
              Row(children: [
                const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 31)),
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 19),
                ),
                TextButton(
                    onPressed: () => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, a, b) => Signup()),
                              (route) => false)
                        },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 19),
                    ))
              ])
            ],
          ),
        )));
  }
}
