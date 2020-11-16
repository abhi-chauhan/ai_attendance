import 'package:ai_attendance/screens/calendar_tab.dart';
import 'package:ai_attendance/screens/home_tab.dart';
import 'package:ai_attendance/screens/profile_tab.dart';
import 'package:ai_attendance/user_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  MyUser userEmail;
  int _currentIndex = 0;
  final tabs = [HomeTab(), CalendarTab(), ProfileTab()];
  void getCurrentUser() {
    try {
      final tempUser = auth.currentUser;
      if (tempUser != null) {
        userEmail = MyUser(email: tempUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<MyUser>(
      create: (context) => userEmail,
      builder: (context, MyUser) => MyUser,
      child: WillPopScope(
        onWillPop: () {
          SystemNavigator.pop(animated: true);
          return new Future(() => true);
        },
        child: Scaffold(
          body: tabs[_currentIndex],
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _currentIndex,
            iconSize: 30,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                backgroundColor: Colors.deepPurple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text("Calendar"),
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text("Profile"),
                backgroundColor: Colors.black,
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
