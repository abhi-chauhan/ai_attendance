import 'package:ai_attendance/components/constants.dart';
import 'package:ai_attendance/screens/loading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../user_email.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String currentMonthSelected = monthList[(DateTime.now().month) - 1];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(Provider.of<MyUser>(context).email)
          //.doc('abhishekchouhan108@gmail.com')
          .collection(DateTime.now().year.toString())
          .doc(currentMonthSelected)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData || !snapshot.data.exists) {
          return LoadingScreen();
        } else {
          var userDocument = snapshot.data;
          int noOfUnpaidLeaves =
              (userDocument['Dates_of_Unpaid_Leaves'].length / 2).round();
          return Scaffold(
            backgroundColor: Colors.black,
            body: ListView(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  SafeArea(
                    child: Text(
                      'MONTHLY ATTENDANCE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    DateTime.now().year.toString(),
                    style: TextStyle(
                      color: Colors.deepPurple[200],
                      fontSize: 30.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Show for:',
                            style: TextStyle(
                              color: Colors.deepPurple[200],
                              fontSize: 15.0,
                            ),
                          ),
                          DropdownButton<String>(
                              dropdownColor: Colors.black,
                              hint: Text(
                                currentMonthSelected,
                                style: TextStyle(color: Colors.white),
                              ),
                              items: monthList.map((String months) {
                                return DropdownMenuItem<String>(
                                  value: months,
                                  child: Text(
                                    months,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (valueSelected) {
                                setState(() {
                                  currentMonthSelected = valueSelected;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 30.0,
                      bottom: 30.0,
                    ),
                    child: SleekCircularSlider(
                      initialValue: userDocument['Percentage'].toDouble(),
                      appearance: CircularSliderAppearance(
                        size: 250.0,
                        infoProperties: InfoProperties(
                          mainLabelStyle: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 50.0,
                          ),
                        ),
                        startAngle: 270.0,
                        angleRange: 360.0,
                        animationEnabled: true,
                        animDurationMultiplier: 1.5,
                        customColors: CustomSliderColors(
                          trackColor: Colors.deepPurple[100],
                          progressBarColors: [
                            Colors.deepPurple,
                            Colors.deepPurple[100],
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Days present this month:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            userDocument['Attendance_Till_Now'].toString(),
                            style: TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            ' Unpaid leaves taken:',
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 25.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            noOfUnpaidLeaves.toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Paid leaves remaining:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            userDocument['No_of_paid_leaves_left'].toString(),
                            style: TextStyle(
                              color: Colors.blue[400],
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Text(data)
                ],
              ),
            ]),
          );
        }
      },
    );
  }
}
