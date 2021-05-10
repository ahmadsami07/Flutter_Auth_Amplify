import 'package:flutter/material.dart';
import '../Services/authentication.dart';
import '../models/User.dart';

class VerifConfirm extends StatefulWidget {
  final User currentUser;
  VerifConfirm({this.currentUser});
  @override
  _VerifConfirmState createState() => _VerifConfirmState();
}

class _VerifConfirmState extends State<VerifConfirm> {
  String verifcode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            padding: EdgeInsets.all(8.0),
            height: 200.0,
            width: MediaQuery.of(context).size.width - 30.0,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7))],
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              Text(
                "Please Confirm The Verification Code Which Has been Sent Over the Email.",
                textAlign: TextAlign.center,
              ),
              TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: '   Verification Code',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (val) {
                    setState(() {
                      verifcode = val;
                    });
                  }),
              SizedBox(height: 10.00),
              ElevatedButton(
                  onPressed: () {
                    auth().confirmation(widget.currentUser, verifcode, context);
                  },
                  child: Text("CONFIRM")),
            ]))
      ]),
    ));
  }
}
