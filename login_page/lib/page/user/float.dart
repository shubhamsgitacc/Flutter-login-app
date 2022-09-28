import 'package:flutter/material.dart';

class Float extends StatelessWidget {
  const Float({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: FloatingActionButton(
          onPressed: () {}, child: Icon(Icons.navigation_sharp)),
    );
  }
}
