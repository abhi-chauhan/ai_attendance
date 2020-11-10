import 'package:ai_attendance/components/main_button.dart';
import 'package:ai_attendance/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController controller1;
  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      duration: Duration(
        minutes: 10,
      ),
      upperBound: 100.0,
      vsync: this,
    );
    controller1.forward();
    controller1.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                    tag: 'logo',
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.25).animate(controller1),
                      child: Container(
                        child: Image.asset(
                          'images/1.png',
                        ),
                        height: 60.0,
                      ),
                    )),
                ColorizeAnimatedTextKit(
                  text: [' ATTENDANCE'],
                  textStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 43.0,
                    fontWeight: FontWeight.w900,
                  ),
                  colors: [
                    Colors.deepPurple,
                    Colors.purple,
                    Colors.white,
                    Colors.deepPurple,
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                title: 'Log In',
                colour: Colors.deepPurple,
              ),
            )
          ],
        ),
      ),
    );
  }
}
