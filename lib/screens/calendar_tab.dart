import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/widgets.dart';

class CalendarTab extends StatefulWidget {
  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  CalendarController _controller;
  DateTime _dateTime = DateTime(2020, 10, 19);
  Map<DateTime, List<dynamic>> _event;
  @override
  void initState() {
    _controller = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Calendar"),
      ),
      backgroundColor: Colors.white,
      body: TableCalendar(
        builders: CalendarBuilders(),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          centerHeaderTitle: true,
        ),
        initialCalendarFormat: CalendarFormat.month,
        calendarController: _controller,
        availableGestures: AvailableGestures.horizontalSwipe,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Colors.blue),
        ),
        calendarStyle: CalendarStyle(
            selectedColor: Colors.blue,
            todayColor: Colors.blue[200],
            weekendStyle: TextStyle(color: Colors.black),
            outsideDaysVisible: false),
      ),
    );
  }
}
