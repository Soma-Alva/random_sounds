import 'package:flutter/material.dart';

class EventModel extends ChangeNotifier {
  final List<String> _events = [];

  List<String> get events => _events;

  void addEvent(String event) {
    _events.add(event);
    notifyListeners();
  }

  void removeEvent(int index) {
    _events.removeAt(index);
    notifyListeners();
  }
}
