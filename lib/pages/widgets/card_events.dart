import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_sounds/pages/cronograma_page.dart';
import 'package:random_sounds/providers/event_model.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({super.key});


  @override
  Widget build(BuildContext context) {
    return 
    // Scaffold(
    //   appBar: AppBar(title: const Text('Eventos')),
    //   body: Column(
    //     children: [
    //       ElevatedButton(
    //         onPressed: () {
    //           final cronograma = _generateCronograma();
    //           final title = 'Evento ${DateTime.now().toString()}';
    //           Provider.of<EventModel>(context, listen: false).addEvent(title, cronograma);
    //         },
    //         child: const Text('Agregar Evento'),
    //       ),
          Consumer<EventModel>(
            builder: (context, eventModel, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: eventModel.events.length,
                  itemBuilder: (context, index) {
                    final event = eventModel.events[index];
                    return Card(
                      child: Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(event.id.toString()),
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
                          print('Eliminando evento ${index.toString()}');
                          eventModel.removeEvent(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Evento eliminado')),
                          );
                        },
                        child: ListTile(
                          title: Text(event.title),
                          //subtitle: const Text('Hora: 7:00 PM'),
                          subtitle: Text('ID - ${event.id}' ),
                          leading: const Icon(Icons.event),
                          trailing: const Icon(Icons.more_vert),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CronogramaPage(event: event),
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
    //     ],
    //   ),
    // );
  }
}
