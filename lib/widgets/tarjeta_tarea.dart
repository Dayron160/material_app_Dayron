import 'package:flutter/material.dart';
import 'package:material/models/tarea.dart';

class TarjetaTarea extends StatelessWidget {
  final Tarea tarea;
  final VoidCallback onEliminar;
  final VoidCallback onCambiarEstado;
  final VoidCallback onEditar;

  const TarjetaTarea({
    super.key,
    required this.tarea,
    required this.onEliminar,
    required this.onCambiarEstado,
    required this.onEditar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Checkbox(
          value: tarea.completada,
          onChanged: (bool? value) => onCambiarEstado(),
          activeColor: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          tarea.titulo,
          style: TextStyle(
            decoration: tarea.completada ? TextDecoration.lineThrough : null,
            color: tarea.completada
                ? Colors.grey
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(tarea.descripcion),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!tarea.completada)
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: onEditar,
                tooltip: 'Editar tarea',
              ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: onEliminar,
              tooltip: 'Eliminar tarea',
            ),
          ],
        ),
      ),
    );
  }
}
