import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'loginscreen.dart';
import 'models/User.dart';
import 'signup_screen.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:loginapp2/login_confirm.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class landingpage extends StatefulWidget {
  final String email;
  landingpage({this.email});
  @override
  _landingpageState createState() => _landingpageState();
}

class _landingpageState extends State<landingpage> {
  User _myUser;
  bool _profilePicUploaded = false;
  final mImagePicker = new ImagePicker();
  void _signout() async {
    try {
      Amplify.Auth.signOut().then((_) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _fetchUser() async {
    try {
      List<User> users = await Amplify.DataStore.query(User.classType,
          where: User.EMAIL.eq(widget.email));
      setState(() {
        _myUser = users.first;
        if (_myUser.profilePic != "") {
          _profilePicUploaded = true;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _uploadPic() async {
    try {
      final pickImage =
          await mImagePicker.getImage(source: ImageSource.gallery);
      User updatedUser =
          _myUser.copyWith(id: _myUser.id, profilePic: pickImage.path);
      await Amplify.DataStore.save(updatedUser);
      setState(() {
        _profilePicUploaded = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_myUser != null)
              Text(
                "Hello! Welcome " + _myUser.email,
                style: TextStyle(
                    fontSize: 15, decorationStyle: TextDecorationStyle.solid),
              ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            if (_myUser.profilePic != "" && _profilePicUploaded)
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: DecorationImage(
                    image: FileImage(File(_myUser.profilePic)),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )
            else
              ElevatedButton(
                  onPressed: () {
                    _uploadPic();
                  },
                  child: Text("Add Photo.")),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Padding(padding: EdgeInsets.only(top: 10)),
            MaterialButton(
              onPressed: () {
                WebView(
                  initialUrl: "https://saloneverywhere.com/sample-profiles",
                  javascriptMode: JavascriptMode.unrestricted,
                );
              },
              elevation: 4,
              color: Theme.of(context).primaryColor,
              disabledColor: Colors.red.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                'Please Take a Look At Our Sample Profiles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  _signout();
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
