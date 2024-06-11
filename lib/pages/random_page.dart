import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_sounds/pages/list_music.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Page'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿No sabes que tocar hoy?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '¡No te preocupes!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ListMusic(),
                  ),
                );
              },
              child: Image.asset(
                'assets/images/play.png',
                width: 400.0,
                height: 400.0,
              ),
            ),
            const Text(
              '¡Dale al botón y te ayudaremos a elegir!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}