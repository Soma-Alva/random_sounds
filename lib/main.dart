import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:random_sounds/pages/home_page.dart';
import 'package:random_sounds/providers/event_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  await initializeDateFormatting('es_ES', null);
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa la base de datos de zonas horarias
  tz.initializeTimeZones();
  const String timeZoneName = 'America/Managua';
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  runApp(
    ChangeNotifierProvider(
      create: (context) => EventModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

