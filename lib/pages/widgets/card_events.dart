import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_sounds/helper/list_sounds.dart';
import 'package:random_sounds/pages/cronograma_page.dart';
import 'package:random_sounds/providers/event_model.dart';

class CardEvent extends StatefulWidget {
  const CardEvent({super.key});

  @override
  State<CardEvent> createState() => _CardEventState();
}

class _CardEventState extends State<CardEvent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(
      builder: (context, eventModel, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: eventModel.events.length,
            itemBuilder: (context, index) {
              return Card(
                child: Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key(eventModel.events[index]),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Eliminar evento'),
                          content: const Text('¿Estás seguro de eliminar el evento?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Sí'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    eventModel.removeEvent(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Evento eliminado')),
                    );
                  },
                  child: ListTile(
                    title: Text(eventModel.events[index]),
                    subtitle: const Text('Hora: 7:00 PM'),
                    leading: const Icon(Icons.event),
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      final selectedEvent = eventModel.events[index];
                      final cronograma = _generateCronograma(selectedEvent);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CronogramaPage(
                            event: selectedEvent,
                            cronograma: cronograma,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<Map<String, String>> _generateCronograma(String selectedEvent) {
    final random = Random();

    final List<Map<String, String>> cronograma = [
      {'Posición': '1', 'Acto': listSoundsAlabanza[random.nextInt(listSoundsAlabanza.length)]},
      {'Posición': '2', 'Acto': listSoundsAlabanza[random.nextInt(listSoundsAlabanza.length)]},
      {'Posición': '3', 'Acto': listSoundsIglesia[random.nextInt(listSoundsIglesia.length)]},
      {'Posición': '4', 'Acto': 'Predica'},
      {'Posición': '5', 'Acto': 'Ofrenda'},
      {'Posición': '6', 'Acto': listSoundsAdoracion[random.nextInt(listSoundsAdoracion.length)]},
      {'Posición': '7', 'Acto': listSoundsAdoracion[random.nextInt(listSoundsAdoracion.length)]},
    ];

    return cronograma;
  }
}