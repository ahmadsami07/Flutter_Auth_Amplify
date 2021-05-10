import 'package:flutter/material.dart';
import './Services/authentication.dart';
import './passwordrecovery.dart';
import 'signup_screen.dart';
import 'package:amplify_flutter/amplify.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  bool _passwordHidden = true;
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
              child: Column(
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                        fillColor: Color(0xffdadbda),
                        contentPadding: EdgeInsets.only(left: 15),
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
                  TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Please Enter Password',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility_off_rounded),
                            onPressed: () {
                              setState(() {
                                _passwordHidden = !_passwordHidden;
                              });
                            },
                          )),
                      obscureText: _passwordHidden,
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
                  SizedBox(height: 5.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(top: 5, bottom: 5, left: 50, right: 50),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.red;
                          if (states.contains(MaterialState.disabled))
                            return Colors.grey;
                          return Colors.red;
                        },
                      ),
                    ),
                    onPressed: () {
                      auth().signin(email, password, context);
                    },
                    child: Center(
                      child: Text('Login'),
                    ),
                  ),
                  SizedBox(height: 3.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => signupscreen()));
                    },
                    child: Center(
                      child: Text('SIGN UP'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
