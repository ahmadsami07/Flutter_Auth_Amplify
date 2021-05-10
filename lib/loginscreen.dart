import 'package:flutter/material.dart';
import 'package:loginapp2/Services/authentication.dart';
import 'package:loginapp2/landing_page.dart';
import 'package:loginapp2/passwordrecovery.dart';

import 'signup_screen.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  var userloggedin;
  @override
  void initState() {
    super.initState();
    Amplify.Auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Amplify.Auth.signOut();
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
                  decoration:
                      InputDecoration(hintText: 'Please Enter Password'),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  }),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConfirmResetScreen()));
                },
                child: Text('Forgot Password?'),
              ),
              //  SizedBox(height: 3.0),
              //ElevatedButton(
              //  onPressed: () {
              //  Amplify.Auth.signOut();
              //},
              //child: Center(child: Text('Sign Out'))),
              SizedBox(height: 5.0),
              ElevatedButton(
                  onPressed: () {
                    if (auth().signin(email, password) != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => landingpage(email: email)));
                    }
                  },
                  child: Center(child: Text('Login'))),
              SizedBox(height: 3.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => signupscreen()));
                  },
                  child: Center(child: Text('SIGN UP'))),
            ]))
      ],
    )));
  }
}
