import 'package:SalonEverywhere/screens/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Widget/appbar.dart';
import '../screens/SampleScreen.dart';
import '../screens/LoginScreen.dart';
import '../screens/LandingPageScreen.dart';
import '../models/User.dart';
import 'package:amplify_flutter/amplify.dart';
import 'dart:io';

class LandingNav extends StatefulWidget {
  final String email;
  LandingNav({this.email});
  @override
  _LandingNavState createState() => _LandingNavState();
}

class _LandingNavState extends State<LandingNav> {
  int _currentIndex = 0;
  List<Widget> _widgetOptions() =>
      [LandingPage(email: widget.email), SampleScreen(), SettingsScreen()];
  final mImagePicker = new ImagePicker();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetCarrier = _widgetOptions();
    return new Scaffold(
      body: _widgetCarrier[_currentIndex],
      appBar: myAppBar(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sample Profiles',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
            backgroundColor: Colors.white,
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
