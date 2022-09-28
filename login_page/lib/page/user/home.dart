import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_page/page/user/dashboard.dart';

import 'delete.dart';
import 'profile.dart';

class Homemain extends StatefulWidget {
  const Homemain({Key? key}) : super(key: key);

  @override
  State<Homemain> createState() => _HomemainState();
}

curUser() async {
  var user = FirebaseAuth.instance.currentUser!;
  print(user.uid);
  var uid = user.uid;
  // return (uid);
}

class _HomemainState extends State<Homemain> {
  int navindex = 0;
  static List<Widget> options = <Widget>[
    // Home(),
    Dashboard(),
    Delete(),
    Profile()
  ];
  void ontap(int index) {
    setState(() {
      navindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome user')),
      body: options.elementAt(navindex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        currentIndex: navindex,
        onTap: ontap,
      ),
    );
  }
}
