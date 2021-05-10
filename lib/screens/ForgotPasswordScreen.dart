import 'package:SalonEverywhere/screens/ConfirmResetPasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import './ConfirmResetPasswordScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  //final LoginData data;

  // ForgotPasswordScreen({@required this.data});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String newemail, newpass, code;
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isEnabled1 = false;
  bool _isEnabled2 = false;
  bool _isEnabled3 = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _isEnabled1 = _emailController.text.isNotEmpty;
      });
    });
    _newPasswordController.addListener(() {
      setState(() {
        _isEnabled2 = _newPasswordController.text.isNotEmpty &&
            _emailController.text.isNotEmpty &&
            _newPasswordController.text.isNotEmpty;
      });
    });
  }

  void _sendPasswordCode(String email) async {
    try {
      final result = await Amplify.Auth.resetPassword(username: newemail);
      if (result.nextStep.updateStep == 'CONFIRM_RESET_PASSWORD_WITH_CODE') {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ConfirmReset(email)));
      }
    } catch (e) {
      print(e.message);
    }
  }

  void _resetPassword(BuildContext context, String newemail, String code,
      String password) async {
    try {
      final res = await Amplify.Auth.confirmPassword(
        username: newemail,
        newPassword: newpass,
        confirmationCode: code,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Password changed successfully. Please log in',
            style: TextStyle(fontSize: 15),
          ),
        ),
      );

      Navigator.of(context).pushReplacementNamed('/');
    } on AuthException catch (e) {
      _showError(context, '${e.message} - ${e.underlyingException}');
    }
  }

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

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 12,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Looks like you forgot your password! Please Enter Your Email To Send A Verification Code.",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              newemail = val;
                            });
                          }),
                      MaterialButton(
                        onPressed: _isEnabled1
                            ? () {
                                _sendPasswordCode(newemail);
                              }
                            : null,
                        elevation: 4,
                        color: Colors.white,
                        disabledColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'SEND VERIFICATION CODE',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
