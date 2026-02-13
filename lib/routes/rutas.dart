import 'package:flutter/material.dart';
import 'package:material/screens/pagina_agregar_tarea.dart';
import 'package:material/screens/pagina_principal.dart';

/// Clase estática para la gestión de rutas de navegación en la aplicación.
class Rutas {
  /// Ruta para la pantalla principal.
  static const String paginaPrincipal = '/';

  /// Ruta para la pantalla de agregar o editar tarea.
  static const String pagAgregarTarea = '/agregar_tarea';

  /// Genera la ruta correspondiente según la configuración [settings].
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
