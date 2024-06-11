import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:random_sounds/helper/list_sounds.dart';
import 'package:random_sounds/pages/home_page.dart';
import 'package:random_sounds/providers/event_model.dart';

String nombreDiaTemp = '';

class ListMusic extends StatelessWidget {
  const ListMusic({super.key});

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulando un retraso en la carga de datos
    return "Datos cargados";
  }

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
      body: FutureBuilder<String>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LoadingIndicator(
                indicatorType: Indicator.pacman,
                colors: [Colors.blue],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tu canciones del día ',
                    style: TextStyle(
                      fontSize: 24.0,
                  )),
                  const NombreDelDiaActual(),
                  const SizedBox(height: 20.0),
                  const Text('Cronograma de actividades: ',
                    style: TextStyle(
                      fontSize: 24.0,
                  )),
                  const CronogramaTable(),
                  const SizedBox(height: 60.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        String capitalizedNombreDiaTemp = nombreDiaTemp.substring(0, 1).toUpperCase() + nombreDiaTemp.substring(1);
                        Provider.of<EventModel>(context, listen: false).addEvent(capitalizedNombreDiaTemp);
                        Navigator.push(
                          context, 
                          CupertinoPageRoute(builder: (context) => const HomePage())
                        );
                      },
                      child: const Text(
                        'Guardar Cronograma',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class NombreDelDiaActual extends StatelessWidget {
  const NombreDelDiaActual({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene la fecha actual
    DateTime now = DateTime.now();
    // Formatea la fecha para obtener el nombre del día
    String nombreDia = DateFormat('EEEE', 'es_ES').format(now);
    nombreDiaTemp = nombreDia;
    String capitalizedNombreDia = nombreDia.substring(0, 1).toUpperCase() + nombreDia.substring(1);

    return Text(
      '$capitalizedNombreDia son:',
      style: const TextStyle(fontSize: 24),
    );
  }
}

class CronogramaTable extends StatelessWidget {
  const CronogramaTable({super.key});

  @override
  Widget build(BuildContext context) {
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

    return SingleChildScrollView(
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text(
              'Posición',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,))
            ),
          DataColumn(
            label: Text(
              'Acto',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,))
            ),
        ],
        rows: cronograma
            .map(
              (item) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      item['Posición']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      )
                    )
                  ),
                  DataCell(
                    Text(
                      item['Acto']!,
                      style: const TextStyle(
                        fontSize: 17,
                      )
                    )
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}