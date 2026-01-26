import 'package:flutter/material.dart';
import 'package:material/screens/pagina_agregar_tarea.dart';
import 'package:material/screens/pagina_principal.dart';

class Rutas {
  static const String paginaPrincipal = '/';
  static const String pagAgregarTarea = '/agregar_tarea';

  static Route<dynamic> generarRuta(RouteSettings settings) {
    switch (settings.name) {
      case paginaPrincipal:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PaginaPpal(),
        );

      case pagAgregarTarea:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PaginaAgregarTarea(),
          settings: settings, // Pasamos los argumentos a la nueva pantalla
        );

      default:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              const Scaffold(body: Center(child: Text('Ruta no encontrada'))),
        );
    }
  }
}
