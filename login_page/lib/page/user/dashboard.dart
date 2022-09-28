import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_page/page/user/float.dart';
import 'package:login_page/page/user/home.dart';

class Dashboard extends StatefulWidget {
  // final String uid;
  // Dashboard({key ? key, @required this.uid}) : super(key: key);
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');

class _DashboardState extends State<Dashboard> {
  final formkey = GlobalKey<FormState>();

  var data = '';
  final datacontroller = TextEditingController();
  @override
  void dispose() {
    datacontroller.dispose();
    super.dispose();
  }

  void cleartext() {
    datacontroller.clear();
  }

  // adddata() {
  //   users.doc(sid).set({'data': data});
  // }

  // final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: Column(
          children: [
            const Text(
              'Enter your data here:',
              style: TextStyle(fontSize: 23),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40)),
            Form(
                child: TextFormField(
              autofocus: false,
              maxLength: 50,
              decoration: const InputDecoration(
                  labelText: 'Enter the data',
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(fontSize: 17, color: Colors.redAccent)),
              controller: datacontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter text';
                }
                return null;
              },
            )),
            const Padding(padding: EdgeInsets.only(top: 40)),
            ElevatedButton(
                onPressed: () async {
                  // curUser();
                  data = datacontroller.text;

                  var crid = FirebaseAuth.instance.currentUser!.uid;
                  print('my cur id is ${crid}');
                  users.doc(crid).set({'data': data});
                  cleartext();

                  // users.doc(crid).collection('userdata').add({'data': data});

                  // users.doc(sid).collection('data').add({'data': data});
                  // par.set({'data': data});

                  // datacoll.doc(sid).collection('data').add({'userdata':data});

                  // toadd.doc(sid).collection('data').add({'data': data});
                  // adddata();
                  // print(data);
                  // print(sid);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: Text(
                    'Add data',
                    style: TextStyle(fontSize: 22),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
