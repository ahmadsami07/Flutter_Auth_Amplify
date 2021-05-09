import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loginapp2/Services/authentication.dart';
import 'package:loginapp2/landing_page.dart';
import 'package:loginapp2/passwordrecovery.dart';
import 'Services/providers.dart';
import 'signup_screen.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:loginapp2/login_confirm.dart';

class landingpage extends StatefulWidget {
  @override
  _landingpageState createState() => _landingpageState();
}

class _landingpageState extends State<landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Hello! Welcome."),
            Container(
              height: 100,
              width: 50,
              child: ElevatedButton(
                onPressed: () {
                  Amplify.Auth.signOut();
                },
                child: Center(
                  child: Text('Sign Out'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
