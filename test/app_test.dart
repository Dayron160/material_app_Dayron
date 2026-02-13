import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material/main.dart' as app;

/// Prueba de integración (End-to-End) para el flujo principal de la aplicación.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Flujo completo: Agregar una tarea y verificar en la lista', (
    WidgetTester tester,
  ) async {
    // 1. Iniciar la aplicación
    app.main();
    await tester.pumpAndSettle();

    // 2. Verificar que estamos en la pantalla principal y no hay tareas (o estado inicial)
    // Asumimos que inicia vacía o buscamos el botón de agregar.
    final fabFinder = find.byType(FloatingActionButton);
    expect(fabFinder, findsOneWidget);

    // 3. Navegar a agregar tarea
    await tester.tap(fabFinder);
    await tester.pumpAndSettle(); // Esperar animación de navegación

    // 4. Llenar el formulario
    final titulo = 'Tarea E2E';
    final descripcion = 'Descripción de prueba integración';

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Título'),
      titulo,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Descripción'),
      descripcion,
    );

    // Ocultar teclado si es necesario para encontrar el botón
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // 5. Guardar tarea
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Esperar navegación de vuelta

    // 6. Verificar que la tarea aparece en la lista
    expect(find.text(titulo), findsOneWidget);
    expect(find.text(descripcion), findsOneWidget);
  });
}
