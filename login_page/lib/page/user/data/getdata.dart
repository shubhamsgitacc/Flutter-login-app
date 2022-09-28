import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// var id = FirebaseAuth.instance.currentUser!.uid;

// class Getdata extends StatelessWidget {
//   const Getdata({required this.documentid});
//   final String documentid;
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     return FutureBuilder<DocumentSnapshot>(
//         future: users.doc().get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;
//             print("${data['data']} as data");
//             return Text("data :${data['data']}");
//           } else if (snapshot.hasError) {
//             return Text("Add the data");
//           }

//           if (snapshot.hasData && !snapshot.data!.exists) {
//             return Text("Document does not exist");
//           }
//           return Text('data');
//         });
//   }
// }
class GetUserName extends StatelessWidget {
  final String documentid;
  const GetUserName({required this.documentid});

  // (this.documentId)

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Data Does not exist please add");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("data:${data['data']}");
        }

        return Text("loading");
      },
    );
  }
}
