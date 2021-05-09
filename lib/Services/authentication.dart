import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:loginapp2/login_confirm.dart';

class auth {
  signup(email, password, context) async {
    try {
      Map<String, String> userAttrbte = {'email': email};

      Amplify.Auth.signUp(
              username: email,
              password: password,
              options: CognitoSignUpOptions(userAttributes: userAttrbte))
          .then((value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => login_confirm(email: email)))
              });
    } on AuthException catch (e) {
      print(e);
    }
  }

  confirmation(email, confirmationcode, context) async {
    try {
      SignUpResult result = await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: confirmationcode);
      if (result.isSignUpComplete) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  signin(email, password) async {
    try {
      SignInResult result =
          await Amplify.Auth.signIn(username: email, password: password);
      return result;
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
