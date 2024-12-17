import 'package:flutter/material.dart';
import 'package:tarea1_2/models/producto_modelo.dart';
import 'package:tarea1_2/styles/estilos.dart';

class ProductoDetalleVista extends StatelessWidget {
  final Producto producto;

  ProductoDetalleVista({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Estilos.colorPrimario,
        title: Text(producto.titulo, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF3E5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                producto.imagen,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              producto.titulo,
              style: Estilos.estiloEncabezado.copyWith(fontSize: 22),
            ),
            SizedBox(height: 8),
            Text(
              "Precio: \$${producto.precio.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              "Categoría: ${producto.categoria}",
              style: Estilos.estiloSubtitulo,
            ),
            SizedBox(height: 16),
            Text(
              "Descripción:",
              style: Estilos.estiloEncabezado.copyWith(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              producto.descripcion,
              style: Estilos.estiloSubtitulo,
            ),
          ],
        ),
      ),
    );
  }
}
