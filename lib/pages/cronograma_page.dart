import 'package:flutter/material.dart';

class CronogramaPage extends StatelessWidget {
  final String event;
  final List<Map<String, String>> cronograma;

  const CronogramaPage({super.key, required this.event, required this.cronograma});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronograma de $event'),
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
      body: CronogramaTable(cronograma: cronograma),
    );
  }
}

class CronogramaTable extends StatelessWidget {
  final List<Map<String, String>> cronograma;

  const CronogramaTable({super.key, required this.cronograma});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        const Text(
          'Cronograma de actividades',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        const SizedBox(height: 20),
        DataTable(
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
          rows: cronograma.map((evento) {
            return DataRow(
              cells: [
                DataCell(
                        Text(
                          evento['Posición']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          )
                        )
                      ),
                DataCell(
                        Text(
                          evento['Acto']!,
                          style: const TextStyle(
                            fontSize: 17,
                          ),  
                        )
                      ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
