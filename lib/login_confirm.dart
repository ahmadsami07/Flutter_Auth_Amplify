import 'package:flutter/material.dart';
import 'package:loginapp2/Services/authentication.dart';

class login_confirm extends StatefulWidget {
  final email;
  login_confirm({this.email});
  @override
  _login_confirmState createState() => _login_confirmState();
}

class _login_confirmState extends State<login_confirm> {
  String verifcode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  decoration: InputDecoration(hintText: 'Verification Code'),
                  onChanged: (val) {
                    setState(() {
                      verifcode = val;
                    });
                  }),
              SizedBox(height: 10.00),
              ElevatedButton(
                  onPressed: () {
                    auth().confirmation(widget.email, verifcode, context);
                  },
                  child: Text("CONFIRM")),
            ]))
      ]),
    ));
  }
}
