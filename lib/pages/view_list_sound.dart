import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_sounds/pages/list_sound_adoracion.dart';
import 'package:random_sounds/pages/list_sound_alabanza.dart';
import 'package:random_sounds/pages/list_sound_iglesia.dart';

class ViewListSound extends StatelessWidget {
  const ViewListSound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de sonidos'),
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
      // crear una tabla para los tres tipos de sonido en alabanza, iglesia, adoracion
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mis Tipos',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const ListSoundAlabanza()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200.0,
                    child: Image.asset(
                      'assets/images/alabanza.png',
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const ListSoundAdoracion()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200.0,
                    child: Image.asset(
                      'assets/images/adoracion.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const ListSoundIglesia()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200.0,
                    child: Image.asset(
                      'assets/images/iglesia.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}