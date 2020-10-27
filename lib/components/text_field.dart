import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Icon icon;
  final String heading;
  final String data;
  MyTextField({this.data, @required this.icon, @required this.heading});
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
            child: icon,
            width: 30.0,
          ),
          SizedBox(
            width: 10.0,
            height: 60.0,
          ),
          Container(
            child: Text(
              heading,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            width: 90.0,
          ),
          Expanded(
            child: Text(
              data,
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
