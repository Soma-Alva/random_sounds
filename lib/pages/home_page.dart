import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_sounds/pages/random_page.dart';
import 'package:random_sounds/pages/view_list_sound.dart';
import 'package:random_sounds/pages/widgets/card_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guía de Alabanza'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
        actions: [
          IconButton(
            onPressed: () {
               Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const ViewListSound()),
              );
            },
            icon: const Icon(
              Icons.remove_red_eye, 
              //Icons.add_circle_outline_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
        ),
        onPressed: () {
          Navigator.push(
            context, 
            CupertinoPageRoute(builder: (context) => const RandomPage())
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 20.0, right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mis eventos',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            CardEvent(),
          ],
        ),
      ),
    );
  }
}
