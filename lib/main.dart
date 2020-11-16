import 'package:ai_attendance/screens/loading_screen.dart';
import 'package:ai_attendance/screens/password_email_sent.dart';
import 'package:ai_attendance/screens/report_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ai_attendance/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String _email = preferences.getString('email');
  runApp(MyApp(
    emailValue: _email,
  ));
}

enum AuthStatus { unknown, notLoggedIn, loggedIn }

class MyApp extends StatefulWidget {
  String emailValue;
  MyApp({this.emailValue});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;
  AuthStatus _authStatus = AuthStatus.unknown;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  // static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    initializeFlutterFire();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      print(_error);
    }

    if (!_initialized) {
      return CircularProgressIndicator();
    }

    String initialScreen;
    switch (widget.emailValue) {
      case null:
        initialScreen = WelcomeScreen.id;
        break;
      default:
        initialScreen = LoginScreen.id;
        break;
    }
    return MaterialApp(
      initialRoute: initialScreen,
      routes: {
        ReportButton.id: (context) => ReportButton(),
        PasswordReset.id: (context) => PasswordReset(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
      },
    );
  }
}
