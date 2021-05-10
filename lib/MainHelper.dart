//Pull in all relevant dependencies

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'screens/LoginScreen.dart';
import 'Services/amplifyconfiguration.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _amplifyconfig = false;

  @override
  void initstate() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();

    try {
      Amplify.addPlugins([auth, analytics]);

      await Amplify.configure(amplifyconfig);

      setState(() {
        _amplifyconfig = true;
      });
    } on AmplifyAlreadyConfiguredException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Amplify.isConfigured ? LoginScreen() : Text('loading'),
    );
  }
}
