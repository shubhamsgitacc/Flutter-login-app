import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:login_page/page/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialization,
        builder: (context, Snapshot) {
          if (Snapshot.hasError) {
            print('error nos');
          }
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Login page',
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
              ),
              home: const Login());
        });
  }
}
