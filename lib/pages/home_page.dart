import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_sounds/helper/list_sounds.dart';
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
  void initState() {
    _loadExcelData();

    super.initState();
  }

Future<void> _copyAssetToLocal() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = "${directory.path}/banco_canciones.xlsx";
  final file = File(path);

  if (!(await file.exists())) {
    final byteData = await rootBundle.load('assets/banco_canciones.xlsx');
    final buffer = byteData.buffer;
    await file.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    print("Archivo copiado a $path");
  } else {
    print("Archivo ya existe en $path");
  }
}

Future<void> _loadExcelData() async {
  try {
    await _copyAssetToLocal();
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/banco_canciones.xlsx";
    final file = File(path);
    print("Intentando leer el archivo en $path");

    if (await file.exists()) {
      var bytes = await file.readAsBytes();
      var excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        print(table);
        if (table == "Hoja 1") {
          var sheet = excel.tables[table];
          for (int i = 4; i < sheet!.rows.length; i++) {
            if (sheet.rows[i][1] != null) listSoundsIglesia.add(sheet.rows[i][1]!.value.toString());
            if (sheet.rows[i][2] != null) listSoundsAlabanza.add(sheet.rows[i][2]!.value.toString());
            if (sheet.rows[i][3] != null) listSoundsAdoracion.add(sheet.rows[i][3]!.value.toString());
          }
        }
      }

      print('test: ${ listSoundsIglesia.length }');

      setState(() {});
    } else {
      print("Archivo no existe en la ruta especificada.");
    }
  } catch (e) {
    print("Error reading Excel file: $e");
  }
}

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
