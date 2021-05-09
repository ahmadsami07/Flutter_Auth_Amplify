import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final user_logged_in_provider =
    ChangeNotifierProvider<userlogstatus>((ref) => userlogstatus());

class userlogstatus extends ChangeNotifier {
  bool userloggedin = false;

  void set_user_currentstate(userstate) {
    userloggedin = userstate;
    notifyListeners();
  }

  bool get_user_currentstate(userstate) {
    return userloggedin;
  }
}
