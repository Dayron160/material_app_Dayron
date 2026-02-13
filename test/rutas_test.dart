import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material/routes/rutas.dart';

/// Pruebas unitarias para la clase Rutas.
void main() {
  group('Rutas Test', () {
    /// Verifica que la ruta principal devuelva PaginaPpal.
    test('generarRuta devuelve PaginaPpal para la ruta "/"', () {
      final settings = RouteSettings(name: Rutas.paginaPrincipal);
      final route = Rutas.generarRuta(settings);

      expect(route, isA<MaterialPageRoute>());
    });

    /// Verifica que la ruta de agregar tarea devuelva PaginaAgregarTarea.
    test(
      'generarRuta devuelve PaginaAgregarTarea para la ruta "/agregar_tarea"',
      () {
        final settings = RouteSettings(name: Rutas.pagAgregarTarea);
        final route = Rutas.generarRuta(settings);

        expect(route, isA<MaterialPageRoute>());
        // Verificamos que se pasen los settings (argumentos)
        expect(route.settings, settings);
      },
    );
  });
}
