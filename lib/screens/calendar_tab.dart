import 'package:ai_attendance/components/calendar_field.dart';
import 'package:ai_attendance/components/main_button.dart';
import 'package:ai_attendance/components/day_details.dart';
import 'package:ai_attendance/screens/report_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/widgets.dart';
import 'package:ai_attendance/components/constants.dart';

import '../user_email.dart';

class CalendarTab extends StatefulWidget {
  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  String _currentMonthSelected = monthList[(DateTime.now().month) - 1];
  String _currentYearSelected = DateTime.now().year.toString();
  String _currentDateSelected = DateTime.now().day.toString();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(Provider.of<MyUser>(context).email)
            .collection(_currentYearSelected)
            .doc(_currentMonthSelected)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData || !snapshot.data.exists) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  "Calendar",
                  style: TextStyle(
                    fontSize: 27.0,
                  ),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: SfCalendar(
                      onTap: (calendarTapDetails) {
                        _currentMonthSelected =
                            monthList[(calendarTapDetails.date.month) - 1];
                        _currentYearSelected =
                            calendarTapDetails.date.year.toString();
                        _currentDateSelected =
                            calendarTapDetails.date.day.toString();
                        setState(() {});
                      },
                      todayHighlightColor: Colors.blue,
                      todayTextStyle: TextStyle(fontSize: 18.0),
                      selectionDecoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.blue, width: 1),
                        shape: BoxShape.circle,
                      ),
                      cellBorderColor: Colors.white,
                      // showDatePickerButton: true,

                      viewHeaderStyle: ViewHeaderStyle(
                          dayTextStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blueGrey,
                      )),
                      headerStyle: CalendarHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blueGrey[800],
                          )),
                      view: CalendarView.month,
                      headerHeight: 50.0,
                      showNavigationArrow: true,
                      monthViewSettings: MonthViewSettings(
                        monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                          ),
                        ),
                        showTrailingAndLeadingDates: false,
                        dayFormat: 'EEE',
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'No Data Available',
                          style: TextStyle(fontSize: 35.0),
                        ),
                      )),
                ],
              ),
            );
          } else {
            var userDocument = snapshot.data;
            int noOfUnpaidLeaves =
                (userDocument['Dates_of_Unpaid_Leaves'].length / 2).round();
            DayDetails dayDetails = DayDetails(
                dates_of_Paid_Leaves: userDocument['Dates_of_Paid_Leaves'],
                dates_of_Unpaid_Leaves: userDocument['Dates_of_Unpaid_Leaves'],
                endTime: userDocument['Endtime'],
                entryTime: userDocument['Entrytime']);

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  "Calendar",
                  style: TextStyle(
                    fontSize: 27.0,
                  ),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SfCalendar(
                      onTap: (calendarTapDetails) {
                        _currentMonthSelected =
                            monthList[(calendarTapDetails.date.month) - 1];
                        _currentYearSelected =
                            calendarTapDetails.date.year.toString();
                        _currentDateSelected =
                            calendarTapDetails.date.day.toString();
                        setState(() {});
                      },
                      todayHighlightColor: Colors.blue,
                      todayTextStyle: TextStyle(fontSize: 18.0),
                      selectionDecoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.blue, width: 1),
                        shape: BoxShape.circle,
                      ),
                      cellBorderColor: Colors.white,
                      viewHeaderStyle: ViewHeaderStyle(
                          dayTextStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blueGrey,
                      )),
                      headerStyle: CalendarHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blueGrey[800],
                          )),
                      view: CalendarView.month,
                      headerHeight: 50.0,
                      showNavigationArrow: true,
                      monthViewSettings: MonthViewSettings(
                        monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                          ),
                        ),
                        showTrailingAndLeadingDates: false,
                        dayFormat: 'EEE',
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListView(children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MyCalendarField(
                                heading: 'Attendance marked as:',
                                data: dayDetails
                                    .getAttendance(_currentDateSelected),
                                color:
                                    dayDetails.getColor(_currentDateSelected),
                                fieldLength: 250.0,
                                bold: true,
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              MyCalendarField(
                                heading: 'Entry Time:',
                                data: dayDetails.getEntry(_currentDateSelected),
                                color: Colors.black,
                                fieldLength: 150.0,
                                bold: false,
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              MyCalendarField(
                                heading: 'Exit Time:',
                                data: dayDetails.getEnd(_currentDateSelected),
                                color: Colors.black,
                                fieldLength: 150.0,
                                bold: false,
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                width: 100.0,
                                child: ReportButton(
                                  date: _currentDateSelected,
                                  month: _currentMonthSelected,
                                  year: _currentYearSelected,
                                ),
                              )
                            ],
                          ),
                        ]),
                      )),
                ],
              ),
            );
          }
        });
  }
}
