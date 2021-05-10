import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../landing_page.dart';
import '../login_confirm.dart';
import '../models/User.dart';

class auth {
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          message,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  signup(email, password, context) async {
    try {
      User myUser = User(name: email, email: email, profilePic: "");

      Map<String, String> userAttrbte = {'email': email};

      Amplify.Auth.signUp(
              username: email,
              password: password,
              options: CognitoSignUpOptions(userAttributes: userAttrbte))
          .then((value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => login_confirm(currentUser: myUser)))
              });
    } on AuthException catch (e) {
      print(e);
    }
  }

  confirmation(User currentUser, confirmationcode, context) async {
    try {
      SignUpResult result = await Amplify.Auth.confirmSignUp(
          username: currentUser.email, confirmationCode: confirmationcode);
      if (result.isSignUpComplete) {
        await Amplify.DataStore.save(currentUser);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => landingpage(email: currentUser.email)));
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  signin(email, password, context) async {
    try {
      SignInResult result =
          await Amplify.Auth.signIn(username: email, password: password);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => landingpage(email: email)));
    } on AuthException catch (e) {
      _showError(context, e.recoverySuggestion);
      print(e.message);
    }
  }
}
