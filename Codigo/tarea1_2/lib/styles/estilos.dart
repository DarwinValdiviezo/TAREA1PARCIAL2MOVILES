import 'package:flutter/material.dart';

class Estilos {
  static const Color colorPrimario = Color(0xFF6B4EFF);
  static const Color colorTexto = Color(0xFF2D3748);
  static const Color colorSecundario = Color(0xFFF3E5F5);

  static const TextStyle estiloEncabezado = TextStyle(
    color: colorTexto,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle estiloSubtitulo = TextStyle(
    color: Colors.grey,
    fontSize: 16,
  );

  static InputDecoration decoracionInput(String etiqueta, IconData icono) {
    return InputDecoration(
      labelText: etiqueta,
      prefixIcon: Icon(icono, color: colorPrimario),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorPrimario),
      ),
    );
  }

  static ButtonStyle estiloBoton = ElevatedButton.styleFrom(
    backgroundColor: colorPrimario,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(vertical: 12),
    elevation: 3,
  );
}
