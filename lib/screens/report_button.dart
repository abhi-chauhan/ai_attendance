import 'package:ai_attendance/components/main_button.dart';
import 'package:ai_attendance/screens/loading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportButton extends StatefulWidget {
  static final String id = "temp_screen";
  final String date;
  final String month;
  final String year;
  ReportButton({this.date, this.year, this.month});

  @override
  _ReportButtonState createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("could not launch $command");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc('Office_details')
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData || !snapshot.data.exists) {
          return LoadingScreen();
        } else {
          var _userDocument = snapshot.data;
          String subject = 'Discrepancy in attendance';
          String emailBody =
              'This is to inform you that there is a discrepancy in attendance marked for ${widget.date}/${widget.month}/${widget.year}';
          return RoundedButton(
            onPressed: () {
              String url =
                  "mailto:${_userDocument['official_mail']}?subject=$subject&body=$emailBody";
              customLaunch(url);
            },
            colour: Colors.red,
            title: 'Report',
          );
        }
      },
    );
  }
}
