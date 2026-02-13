import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material/models/tarea.dart';
import 'package:material/screens/pagina_agregar_tarea.dart';

/// Pruebas de widget para PaginaAgregarTarea.
void main() {
  /// Función auxiliar para cargar el widget bajo prueba.
  Widget createWidgetUnderTest() {
    return const MaterialApp(home: PaginaAgregarTarea());
  }

  testWidgets('PaginaAgregarTarea renderiza campos y botón correctamente', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(
      find.widgetWithText(AppBar, 'Agregar Tarea'),
      findsOneWidget,
    ); // Título AppBar

    expect(
      find.byType(TextFormField),
      findsNWidgets(2),
    ); // Título y Descripción

    expect(
      find.byType(DropdownButtonFormField<CategoriaTarea>),
      findsOneWidget,
    ); // Categoría

    expect(
      find.widgetWithText(ElevatedButton, 'Agregar Tarea'),
      findsOneWidget,
    ); // Botón guardar
  });

  testWidgets('Muestra errores de validación si los campos están vacíos', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.pumpWidget(createWidgetUnderTest());

    // Act
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Rebuild para mostrar errores

    // Assert
    expect(find.text('Ingrese un título'), findsOneWidget);
    expect(find.text('Ingrese una descripción'), findsOneWidget);
  });

  testWidgets('Permite ingresar texto en los campos', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.pumpWidget(createWidgetUnderTest());

    // Act
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Título'),
      'Nueva Tarea',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Descripción'),
      'Detalle de la tarea',
    );
    await tester.pump();

    // Assert
    expect(find.text('Nueva Tarea'), findsOneWidget);
    expect(find.text('Detalle de la tarea'), findsOneWidget);
  });
}
