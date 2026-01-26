import 'package:material/core/colores.dart';
import 'package:flutter/material.dart';

class BotonColor extends StatelessWidget {
  const BotonColor({
    super.key,
    required this.cambiarColor,
    required this.colorElegido,
  });

  final Function(int) cambiarColor;
  final Colores colorElegido;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.opacity_outlined),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(Colores.values.length, (index) {
          final color = Colores.values[index];
          return PopupMenuItem(
            value: index,
            enabled: color != colorElegido,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(Icons.opacity_outlined, color: color.color),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(color.etiqueta),
                ),
              ],
            ),
          );
        });
      },
      onSelected: cambiarColor,
    );
  }
}
