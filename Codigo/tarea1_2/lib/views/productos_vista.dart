import 'package:flutter/material.dart';
import 'package:tarea1_2/controllers/productos_controlador.dart';
import 'package:tarea1_2/styles/estilos.dart';
import 'package:tarea1_2/views/producto_detalle_vista.dart';

import '../models/producto_modelo.dart';
import 'agregar_producto_vista.dart';

class ProductosVista extends StatefulWidget {
  @override
  _ProductosVistaState createState() => _ProductosVistaState();
}

class _ProductosVistaState extends State<ProductosVista> {
  final _controlador = ControladorProductos();
  List<Producto> _productos = [];

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  Future<void> _cargarProductos() async {
    final productos = await _controlador.leerProductos();
    setState(() {
      _productos = productos;
    });
  }

  void _mostrarAlertaEliminar(Producto producto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Eliminar Producto", style: Estilos.estiloEncabezado),
          content: Text("¿Estás seguro de eliminar \"${producto.titulo}\"?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                await _controlador.eliminarProducto(producto.id);
                Navigator.pop(context);
                _cargarProductos();
              },
              child: Text("Eliminar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E5F5),
      appBar: AppBar(
        title:
            Text("Lista de Productos", style: TextStyle(color: Colors.white)),
        backgroundColor: Estilos.colorPrimario,
        centerTitle: true,
      ),
      body: _productos.isEmpty
          ? Center(
              child: Text("No hay productos disponibles",
                  style: Estilos.estiloEncabezado))
          : ListView.builder(
              itemCount: _productos.length,
              itemBuilder: (context, index) {
                final producto = _productos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductoDetalleVista(producto: producto),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.network(
                        producto.imagen,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.broken_image, size: 50),
                      ),
                      title: Text(producto.titulo,
                          style:
                              Estilos.estiloEncabezado.copyWith(fontSize: 16)),
                      subtitle: Text("\$${producto.precio.toStringAsFixed(2)}",
                          style: Estilos.estiloSubtitulo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AgregarProductoVista(producto: producto),
                                ),
                              );
                              _cargarProductos();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _mostrarAlertaEliminar(producto),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AgregarProductoVista()),
          );
          _cargarProductos();
        },
        backgroundColor: Estilos.colorPrimario,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
