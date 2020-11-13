import 'dart:ui';
import 'package:flutter/material.dart';

class DayDetails {
  final String dates_of_Paid_Leaves;
  final String dates_of_Unpaid_Leaves;
  final String endTime;
  final String entryTime;
  Map<int, List<String>> details = {};
  List<String> values = [];
  DayDetails(
      {this.dates_of_Paid_Leaves,
      this.dates_of_Unpaid_Leaves,
      this.endTime,
      this.entryTime}) {
    for (int i = 0; i < dates_of_Paid_Leaves.length; i += 2) {
      details[int.parse(dates_of_Paid_Leaves.substring(i, i + 2))] = [
        'Paid Leave'
      ];
    }
    for (int i = 0; i < dates_of_Unpaid_Leaves.length; i += 2) {
      details[int.parse(dates_of_Unpaid_Leaves.substring(i, i + 2))] = [
        'UnPaid Leave'
      ];
    }
    int i = 0;
    for (; i < endTime.length; i += 6) {
      details[int.parse(entryTime.substring(i, i + 2))] = [
        'Present',
        entryTime.substring(i + 2, i + 4) +
            ':' +
            entryTime.substring(i + 4, i + 6),
        endTime.substring(i + 2, i + 4) + ':' + endTime.substring(i + 4, i + 6)
      ];
    }
    if (entryTime.length > endTime.length) {
      details[int.parse(entryTime.substring(i, i + 2))] = [
        'Present',
        entryTime.substring(i + 2, i + 4) +
            ':' +
            entryTime.substring(i + 4, i + 6)
      ];
    }
  }
  String getAttendance(String date) {
    if (details[int.parse(date)] == null) {
      return 'NA';
    }
    return details[int.parse(date)][0];
  }

  String getEntry(String date) {
    if (details[int.parse(date)] == null) {
      return 'NA';
    } else if (details[int.parse(date)][0] == 'Present') {
      return details[int.parse(date)][1];
    } else {
      return 'NA';
    }
  }

  String getEnd(String date) {
    if (details[int.parse(date)] == null) {
      return 'NA';
    } else if (details[int.parse(date)][0] == 'Present') {
      if (details[int.parse(date)].length == 3) {
        return details[int.parse(date)][2];
      } else
        return 'NA';
    } else {
      return 'NA';
    }
  }

  Color getColor(String date) {
    if (details[int.parse(date)] == null) {
      return Colors.black;
    }
    if (details[int.parse(date)][0] == 'Present') {
      return Colors.green;
    } else if (details[int.parse(date)][0] == 'Paid Leave') {
      return Colors.deepOrangeAccent;
    } else {
      return Colors.red;
    }
  }
}
