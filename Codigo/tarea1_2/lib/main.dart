import 'package:flutter/material.dart';
import 'package:tarea1_2/views/bienvenida_vista.dart';

void main() {
  runApp(TiendaApp());
}

class TiendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tienda E-commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BienvenidaVista(),
    );
  }
}
