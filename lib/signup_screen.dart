import 'package:flutter/material.dart';
import './Services/authentication.dart';

class signupscreen extends StatefulWidget {
  @override
  _signupscreenState createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  String password, email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.all(8.0),
            height: 300.0,
            width: MediaQuery.of(context).size.width - 30.0,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7))],
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(children: [
              TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  }),
              TextFormField(
                  decoration: InputDecoration(hintText: 'Set Up Password'),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  }),
              SizedBox(height: 10.0),
              ElevatedButton(
                  onPressed: () {
                    auth().signup(email, password, context);
                  },
                  child: Center(child: Text('CONFIRM')))
            ]))
      ],
    )));
  }
}
