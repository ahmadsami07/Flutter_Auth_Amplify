import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';

class ConfirmResetScreen extends StatefulWidget {
  //final LoginData data;

  // ConfirmResetScreen({@required this.data});

  @override
  _ConfirmResetScreenState createState() => _ConfirmResetScreenState();
}

class _ConfirmResetScreenState extends State<ConfirmResetScreen> {
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
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Enter Email',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              newemail = val;
                            });
                          }),
                      SizedBox(height: 10),
                      TextField(
                          controller: _newPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Enter new password',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              newpass = val;
                            });
                          }),
                      SizedBox(height: 10),
                      TextField(
                          controller: _confirmController,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Enter confirmation code',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              code = val;
                            });
                          }),
                      SizedBox(height: 5),
                      MaterialButton(
                        onPressed: _isEnabled1
                            ? () {
                                Amplify.Auth.resetPassword(username: newemail);
                              }
                            : null,
                        elevation: 4,
                        color: Theme.of(context).primaryColor,
                        disabledColor: Colors.deepPurple.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'SEND VERIFICATION CODE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      MaterialButton(
                        onPressed: _isEnabled2
                            ? () {
                                _resetPassword(
                                    context, newemail, code, newpass);
                              }
                            : null,
                        elevation: 4,
                        color: Theme.of(context).primaryColor,
                        disabledColor: Colors.deepPurple.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'RESET PASSWORD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
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
