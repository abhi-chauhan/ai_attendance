import 'package:ai_attendance/components/main_button.dart';
import 'package:ai_attendance/components/text_field.dart';
import 'package:ai_attendance/screens/password_email_sent.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _auth = FirebaseAuth.instance;
  User currentUser;
  bool spinner = false;
  void getCurrentUser() async {
    try {
      final tempUser = await _auth.currentUser;
      if (tempUser != null) {
        currentUser = tempUser;
        print(currentUser.email);
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
    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Image.asset(
                  "images/profile1.jpg",
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Abhishek Chauhan",
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                MyTextField(
                  icon: Icon(
                    Icons.supervisor_account,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  heading: 'Department',
                  data: 'CSE',
                ),
                SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                  icon: Icon(
                    Icons.mail_outline,
                    color: Colors.deepPurple,
                    size: 30.0,
                  ),
                  heading: 'Email',
                  data: 'abhishekchouhan108@gmail.com',
                ),
                SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                  icon: Icon(
                    Icons.smartphone,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  heading: 'Phone',
                  data: '9888588108',
                ),
                SizedBox(
                  height: 10.0,
                ),
                RoundedButton(
                  onPressed: () async {
                    setState(() {
                      spinner = true;
                    });
                    await _auth.sendPasswordResetEmail(
                        email: currentUser.email);
                    setState(() {
                      spinner = false;
                    });
                    Navigator.pushNamed(context, PasswordReset.id);
                  },
                  title: 'Change Password',
                  colour: Colors.black,
                ),
                RoundedButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pop(context);
                  },
                  title: 'SIGN OUT',
                  colour: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
