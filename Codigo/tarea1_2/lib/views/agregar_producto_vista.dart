import 'package:flutter/material.dart';
import 'package:tarea1_2/controllers/productos_controlador.dart';
import 'package:tarea1_2/models/producto_modelo.dart';
import 'package:tarea1_2/styles/estilos.dart';

class AgregarProductoVista extends StatefulWidget {
  final Producto? producto;

  AgregarProductoVista({this.producto});

  @override
  _AgregarProductoVistaState createState() => _AgregarProductoVistaState();
}

class _AgregarProductoVistaState extends State<AgregarProductoVista> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _precioController = TextEditingController();
  final _descripcionController = TextEditingController();
  String _categoriaSeleccionada = "";
  List<String> _categorias = [];
  String _imagen = "";

  final _controlador = ControladorProductos();

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
    if (widget.producto != null) {
      _tituloController.text = widget.producto!.titulo;
      _precioController.text = widget.producto!.precio.toString();
      _descripcionController.text = widget.producto!.descripcion;
      _categoriaSeleccionada = widget.producto!.categoria;
      _imagen = widget.producto!.imagen;
    } else {
      _imagen =
          "https://i.pinimg.com/736x/7c/70/7d/7c707de1090d4501b42ce7360330973b.jpg";
    }
  }

  Future<void> _cargarCategorias() async {
    final categorias = await _controlador.obtenerCategoriasDeAPI();
    setState(() {
      _categorias = categorias;
      if (_categoriaSeleccionada.isEmpty && categorias.isNotEmpty) {
        _categoriaSeleccionada = categorias[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E5F5),
      appBar: AppBar(
        backgroundColor: Estilos.colorPrimario,
        title: Text(
          widget.producto == null ? "Agregar Producto" : "Editar Producto",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: Estilos.decoracionInput("Título", Icons.title),
                  validator: (value) =>
                      value!.isEmpty ? "El título es obligatorio" : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _precioController,
                  decoration:
                      Estilos.decoracionInput("Precio", Icons.attach_money),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? "El precio es obligatorio" : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _descripcionController,
                  decoration:
                      Estilos.decoracionInput("Descripción", Icons.description),
                  validator: (value) =>
                      value!.isEmpty ? "La descripción es obligatoria" : null,
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _categoriaSeleccionada,
                  items: _categorias
                      .map((categoria) => DropdownMenuItem(
                            value: categoria,
                            child: Text(categoria),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _categoriaSeleccionada = value!;
                    });
                  },
                  decoration:
                      Estilos.decoracionInput("Categoría", Icons.category),
                ),
                SizedBox(height: 20),
                Image.network(_imagen, width: 100, height: 100),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final nuevoProducto = Producto(
                        id: widget.producto?.id ?? 0,
                        titulo: _tituloController.text,
                        precio: double.parse(_precioController.text),
                        descripcion: _descripcionController.text,
                        categoria: _categoriaSeleccionada,
                        imagen: _imagen,
                      );

                      if (widget.producto == null) {
                        _controlador.crearProducto(nuevoProducto);
                      } else {
                        _controlador.actualizarProducto(nuevoProducto);
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: Estilos.estiloBoton,
                  child: Text("Guardar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
