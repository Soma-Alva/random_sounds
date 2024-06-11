import 'package:flutter/material.dart';
import 'package:random_sounds/helper/list_sounds.dart';

class ListSoundAdoracion extends StatelessWidget {
  const ListSoundAdoracion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Adoración'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adoración',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
            child: ListView.separated(
              itemCount: listSoundsAdoracion.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listSoundsAdoracion[index]),
                  trailing: const Icon(
                    Icons.music_note,
                    color: Colors.blue,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
          ],
        ),
      ),
    );
  }
}