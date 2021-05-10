import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'LoginScreen.dart';
import '../models/User.dart';
import 'package:amplify_flutter/amplify.dart';
import 'dart:io';

class LandingPage extends StatefulWidget {
  final String email;
  LandingPage({this.email});
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _myUser;
  bool _profilePicUploaded = false;
  String profilePic;
  final mImagePicker = new ImagePicker();

  void _signOut() async {
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
        if (_myUser.profilePic != null) {
          _profilePicUploaded = true;
          profilePic = _myUser.profilePic;
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
        profilePic = pickImage.path;
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
    super.initState();
    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Dashboard ",
              style: new TextStyle(color: Colors.red, fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "Welcome To Your SalonEverywhere Account. ",
              style: new TextStyle(color: Colors.red, fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            Text(
              "The Platform For Beauty & Hair Pros.",
              style: new TextStyle(color: Colors.red, fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            if (_myUser.profilePic != null && _profilePicUploaded)
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: DecorationImage(
                    image: FileImage(File(profilePic)),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton(
              onPressed: () {
                _uploadPic();
              },
              child: Text("Update Picture"),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              padding: EdgeInsets.all(8.0),
              height: 90.0,
              width: MediaQuery.of(context).size.width - 30.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7))],
                  borderRadius: BorderRadius.circular(20.0)),
              child: Text(
                "User Details\n User Email: " + _myUser.email,
                style: new TextStyle(color: Colors.red, fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "Please check out our Sample Profiles by clicking the Sample Profiles Tab below!",
              style: new TextStyle(color: Colors.red, fontSize: 16.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ));
  }
}
