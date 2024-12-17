import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarea1_2/models/producto_modelo.dart';
import 'package:http/http.dart' as http;

class ControladorProductos {
  final String _urlBase = "https://fakestoreapi.com/products";

  Future<List<Producto>> obtenerProductosDeAPI() async {
    final respuesta = await http.get(Uri.parse(_urlBase));
    if (respuesta.statusCode == 200) {
      final List<dynamic> datos = json.decode(respuesta.body);
      return datos.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar productos desde la API");
    }
  }

  Future<List<String>> obtenerCategoriasDeAPI() async {
    final urlCategorias = "https://fakestoreapi.com/products/categories";
    final respuesta = await http.get(Uri.parse(urlCategorias));
    if (respuesta.statusCode == 200) {
      return List<String>.from(json.decode(respuesta.body));
    } else {
      throw Exception("Error al cargar categorías");
    }
  }

  Future<void> guardarProductos(List<Producto> productos) async {
    final prefs = await SharedPreferences.getInstance();
    final productosJson =
        productos.map((producto) => producto.toJson()).toList();
    await prefs.setString('productos', jsonEncode(productosJson));
  }

  Future<List<Producto>> leerProductos() async {
    final prefs = await SharedPreferences.getInstance();
    final productosJson = prefs.getString('productos');
    if (productosJson != null) {
      try {
        final List<dynamic> productosMap = jsonDecode(productosJson);
        return productosMap.map((map) => Producto.fromJson(map)).toList();
      } catch (e) {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<void> crearProducto(Producto producto) async {
    final productos = await leerProductos();
    producto = Producto(
      id: productos.isEmpty ? 1 : productos.last.id + 1,
      titulo: producto.titulo,
      precio: producto.precio,
      descripcion: producto.descripcion,
      categoria: producto.categoria,
      imagen: producto.imagen,
    );
    productos.insert(0, producto);
    await guardarProductos(productos);
  }

  Future<void> actualizarProducto(Producto producto) async {
    final productos = await leerProductos();
    final index = productos.indexWhere((p) => p.id == producto.id);
    if (index != -1) {
      productos[index] = producto;
      await guardarProductos(productos);
    }
  }

  Future<void> eliminarProducto(int id) async {
    final productos = await leerProductos();
    productos.removeWhere((producto) => producto.id == id);
    await guardarProductos(productos);
  }
}
