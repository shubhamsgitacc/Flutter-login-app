import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/page/user/data/getdata.dart';
import 'package:login_page/page/user/home.dart';

class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  var id = FirebaseAuth.instance.currentUser!.uid;

  List<String> docsid = [];
  Future getdocid() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then(((value) => value.docs.forEach((element) {
              // if (id == element) {
              //   print(element.reference);
              // }

              print(docsid);
              // print(element.reference);
              docsid.add(element.reference.id);
            })));
  }

  // void initState() {
  //   getdocid();
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
          const Padding(padding: EdgeInsets.only(top: 70)),
          const Text('Delete Data from here', style: TextStyle(fontSize: 23)),
          Container(
              height: 100,
              child: Expanded(child: FutureBuilder(
                  // future: getdocid(),
                  builder: (context, value) {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        child: ListTile(
                          title: GetUserName(documentid: id),
                          tileColor: Colors.orangeAccent,
                          contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        ),
                      );
                    }));
              }))),
          const Padding(padding: EdgeInsets.only(bottom: 30)),
          ElevatedButton(
              onPressed: () {
                print('${id} this is id cr');
                // print(id);
                FirebaseFirestore.instance.collection('users').doc(id).delete();
                setState(() {});
              },
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Text(
                    'Delete',
                    style: TextStyle(fontSize: 23),
                  )))
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
            child: const Icon(Icons.navigation)));
  }
}
