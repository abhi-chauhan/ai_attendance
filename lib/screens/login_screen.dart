import 'dart:io';
import 'package:ai_attendance/components/main_button.dart';
import 'package:ai_attendance/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'file:///C:/Users/balra/AndroidStudioProjects/ai_attendance/lib/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ai_attendance/components/alert_box.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController controller2;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  String _error = null;
  SharedPreferences preferences;
  void automaticSignIn() async {
    setState(() {
      spinner = true;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushNamed(context, HomeScreen.id);

        preferences.setString('email', email);
        preferences.setString('password', password);
      }
      setState(() {
        spinner = false;
      });
    } catch (e) {
      setState(() {
        _error = e.message;
        spinner = false;
      });
    }
  }

  void emailPasswordCheck() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getString('email') != null) {
      email = preferences.getString('email');
      password = preferences.getString('password');
      automaticSignIn();
    }
  }

  @override
  void initState() {
    super.initState();
    emailPasswordCheck();

    controller2 = AnimationController(
      duration: Duration(
        minutes: 10,
      ),
      upperBound: 100.0,
      vsync: this,
    );
    controller2.forward();
    controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: spinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(children: <Widget>[
              AlertBox(
                error: _error,
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
              SizedBox(
                height: 150.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.25).animate(controller2),
                      child: Container(
                        height: 150.0,
                        child: Image.asset('images/1.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (input) {
                      email = input;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (input) {
                      password = input;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  RoundedButton(
                    onPressed: () async {
                      setState(() {
                        spinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, HomeScreen.id);
                          _error = null;
                          preferences.setString('email', email);
                          preferences.setString('password', password);
                        }
                        setState(() {
                          spinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          _error = e.message;
                          spinner = false;
                        });
                      }
                    },
                    title: 'submit',
                    colour: Colors.deepPurple,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
