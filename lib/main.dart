import 'package:flutter/material.dart';
import 'package:material/routes/rutas.dart';
import 'package:material/screens/theme_provider.dart';
import 'package:provider/provider.dart';

/// Punto de entrada de la aplicación Flutter.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

/// Widget raíz de la aplicación que configura el tema y las rutas.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: Rutas.paginaPrincipal,
      onGenerateRoute: Rutas.generarRuta,
    );
  }
}
