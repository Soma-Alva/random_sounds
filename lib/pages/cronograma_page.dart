import 'package:flutter/material.dart';
import '../helper/database_helper.dart';

class CronogramaPage extends StatelessWidget {
  final Event event;

  const CronogramaPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
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
      body: Column(
        children: [
          const SizedBox(height: 30.0),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 20.0, right: 15.0),
            child: Text(
              'Cronograma de actividades',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ),
          const SizedBox(height: 30.0),
          DataTable(
            columns: const [
              DataColumn(
                label: Text(
                  'Posición',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              DataColumn(
                label: Text(
                  'Acto',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
            rows: event.cronograma
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          item['Posición']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          item['Acto']!,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
