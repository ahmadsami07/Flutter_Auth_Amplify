import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget myAppBar(BuildContext context) {
  return AppBar(
    title: Text("SalonEverywhere"),
    actions: [
      IconButton(
        icon: Image.asset('assets/images/ls2.png'),
        onPressed: () {},
      ),
    ],
  );
}
