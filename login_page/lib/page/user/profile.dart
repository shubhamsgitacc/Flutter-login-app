import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/page/user/float.dart';
import 'package:login_page/page/user/home.dart';

import '../login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formkey = GlobalKey<FormState>();
  var email = '';
  final emailcontroller = TextEditingController();
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  var userid = FirebaseAuth.instance.currentUser!.uid;
  var useremail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            child: ListView(children: [
              Column(
                children: [
                  // const Text(
                  //   'Change Password?',
                  //   style: TextStyle(fontSize: 22),
                  // ),
                  // const Padding(padding: EdgeInsets.only(top: 30)),
                  // TextFormField(
                  //   autofocus: false,
                  //   decoration: const InputDecoration(
                  //       labelText: 'Enter your email',
                  //       labelStyle: TextStyle(fontSize: 23),
                  //       border: OutlineInputBorder(),
                  //       errorStyle:
                  //           TextStyle(fontSize: 18, color: Colors.redAccent)),
                  //   controller: emailcontroller,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter email';
                  //     } else if (!value.contains('@')) {
                  //       return 'Please enter valid email';
                  //     }
                  //   },
                  // ),
                  // const Padding(padding: EdgeInsets.only(top: 30)),
                  // ElevatedButton(
                  //     onPressed: () {},
                  //     child: const Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  //       child: Text(
                  //         'Change Password',
                  //         style: TextStyle(fontSize: 22),
                  //       ),
                  //     )),
                  const Text('Welcome user!!', style: TextStyle(fontSize: 23)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

                  Text('${useremail}', style: const TextStyle(fontSize: 28)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

                  const Text('Your user id', style: TextStyle(fontSize: 23)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Text('${userid}', style: const TextStyle(fontSize: 21)),

                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

                  const Padding(padding: EdgeInsets.only(top: 10)),
                  ElevatedButton(
                      onPressed: () async => {
                            await FirebaseAuth.instance.signOut(),
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, a, b) => Login()),
                                (route) => false)
                          },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 22),
                        ),
                      )),
                ],
              ),

              // FloatingActionButton(
              //     child: Icon(Icons.navigation),
              //     onPressed: () {
              //       Navigator.pushAndRemoveUntil(
              //           context,
              //           PageRouteBuilder(
              //               pageBuilder: (context, a, b) => Homemain(),
              //               transitionDuration: Duration(seconds: 4)),
              //           (route) => false);
              //     })
            ])),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, a, b) => Homemain(),
                      transitionDuration: Duration(seconds: 4)),
                  (route) => false);
            },
            child: Icon(Icons.navigation)));
  }
}
