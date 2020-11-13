import 'package:flutter/material.dart';

class MyCalendarField extends StatelessWidget {
  final String heading;
  final String data;
  final Color color;
  final double fieldLength;
  final bool bold;
  MyCalendarField(
      {this.data,
      @required this.heading,
      this.color,
      this.fieldLength,
      this.bold});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          Container(
            child: Text(
              heading,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontStyle: FontStyle.italic),
            ),
            width: fieldLength,
          ),
          Expanded(
            child: Text(
              data,
              style: TextStyle(
                fontSize: 23.0,
                color: color,
                fontStyle: FontStyle.italic,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
