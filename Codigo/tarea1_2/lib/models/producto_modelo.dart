class Producto {
  final int id;
  final String titulo;
  final double precio;
  final String descripcion;
  final String categoria;
  final String imagen;

  Producto({
    required this.id,
    required this.titulo,
    required this.precio,
    required this.descripcion,
    required this.categoria,
    required this.imagen,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      titulo: json['title'],
      precio: json['price'].toDouble(),
      descripcion: json['description'],
      categoria: json['category'],
      imagen: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': titulo,
      'price': precio,
      'description': descripcion,
      'category': categoria,
      'image': imagen,
    };
  }
}
