import 'package:flutter/material.dart';
import '../helper/database_helper.dart';

class EventModel extends ChangeNotifier {
  final List<Event> _events = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Event> get events => _events;

  EventModel() {
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await _databaseHelper.getEvents();
    _events.addAll(events);
    notifyListeners();
  }

  Future<void> addEvent(String title, List<Map<String, String>> cronograma) async {
    final event = Event(title: title, cronograma: cronograma);
    event.id = await _databaseHelper.insertEvent(event); // Obtener el ID del evento insertado
    _events.insert(0, event); // Insertar al principio de la lista
    notifyListeners();
  }

  Future<void> removeEvent(int index) async {
    final event = _events[index];
    print('Removing event: ${event.id}');
    await _databaseHelper.deleteEvent(event.id!);
    _events.removeAt(index);
    notifyListeners();
  }
}
