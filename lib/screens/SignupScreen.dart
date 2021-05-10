import 'package:flutter/material.dart';
import '../Services/authentication.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String password, email;
  bool _passwordHidden = true;
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
                color: Colors.red,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7))],
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(children: [
              Text(
                "Don't have an account? Please enter your email and open a new account!",
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              TextFormField(
                  decoration: InputDecoration(
                    fillColor: Color(0xffdadbda),
                    contentPadding: EdgeInsets.only(left: 15),
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  }),
              const Padding(padding: EdgeInsets.only(top: 15)),
              TextFormField(
                  decoration: InputDecoration(
                    fillColor: Color(0xffdadbda),
                    contentPadding: EdgeInsets.only(left: 15),
                    filled: true,
                    prefixIcon: Icon(Icons.vpn_key),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Please Enter Password',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility_off_rounded),
                      onPressed: () {
                        setState(() {
                          _passwordHidden = !_passwordHidden;
                        });
                      },
                    ),
                  ),
                  obscureText: _passwordHidden,
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
