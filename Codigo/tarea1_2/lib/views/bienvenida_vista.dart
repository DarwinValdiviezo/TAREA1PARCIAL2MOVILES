import 'package:flutter/material.dart';
import 'package:tarea1_2/styles/estilos.dart';
import 'productos_vista.dart';

class BienvenidaVista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Estilos.colorPrimario.withOpacity(0.8),
              Estilos.colorPrimario.withOpacity(0.5),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.store,
                      size: 100, color: Estilos.colorPrimario),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Bienvenido a",
                style: Estilos.estiloEncabezado
                    .copyWith(fontSize: 24, color: Estilos.colorTexto),
              ),
              Text(
                "Tienda E-commerce",
                style: Estilos.estiloEncabezado.copyWith(
                    fontSize: 28,
                    color: Estilos.colorPrimario,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductosVista(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Estilos.colorPrimario,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "¡Explora nuestra tienda y descubre lo mejor!",
                style: Estilos.estiloSubtitulo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
