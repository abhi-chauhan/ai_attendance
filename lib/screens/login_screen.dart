import 'dart:io';
import 'package:ai_attendance/components/main_button.dart';
import 'package:ai_attendance/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'file:///C:/Users/balra/AndroidStudioProjects/ai_attendance/lib/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ai_attendance/components/alert_box.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

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

  @override
  void initState() {
    super.initState();

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
              SizedBox(
                height: 150.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AlertBox(
                    error: _error,
                    onPressed: () {
                      setState(() {
                        _error = null;
                      });
                    },
                  ),
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
