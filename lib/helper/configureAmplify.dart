import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loginapp2/Services/providers.dart';
import '../amplifyconfiguration.dart';

Future<void> configureAmplify() async {
  final auth = AmplifyAuthCognito();
  final analytics = AmplifyAnalyticsPinpoint();

  try {
    Amplify.addPlugins([auth, analytics]);

    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException catch (e) {
    print(e);
  }
}
