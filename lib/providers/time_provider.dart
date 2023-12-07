import 'dart:async';

import 'package:flutter/material.dart';

class TimeModel extends ChangeNotifier {
  late String currentTime;
  late String currentDate;

  TimeModel() {
    // Initialize with the current time
    currentTime = _getCurrentTime();
    currentDate = _getCurrentDate();
    // Update the time every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      currentTime = _getCurrentTime();
      currentDate = _getCurrentDate();
      notifyListeners();
    });
  }

  String _getCurrentTime() {
    final DateTime now = DateTime.now();
    return "${now.hour}:${now.minute}:${now.second}";
  }

  String _getCurrentDate() {
    final DateTime now = DateTime.now();
    return "${now.day}/${now.month}/${now.year} ${now.hour >= 12 ? 'PM' : 'AM'}";
  }
}